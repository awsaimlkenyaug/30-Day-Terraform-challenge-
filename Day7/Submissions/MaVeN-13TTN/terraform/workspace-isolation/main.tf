# Day 7: Terraform State Isolation via Workspaces
# This configuration demonstrates how to use Terraform workspaces
# to isolate state between different environments

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration for remote state
  backend "s3" {
    bucket         = "maven-13ttn-terraform-state-bucket"
    key            = "workspace-isolation/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source to get the current workspace
locals {
  workspace_name = terraform.workspace
  environment    = terraform.workspace == "default" ? "dev" : terraform.workspace

  # Environment-specific configurations
  environment_config = {
    dev = {
      instance_type = "t2.micro"
      min_size      = 1
      max_size      = 2
      desired_size  = 1
      cidr_block    = "10.0.0.0/16"
    }
    staging = {
      instance_type = "t3.small"
      min_size      = 2
      max_size      = 4
      desired_size  = 2
      cidr_block    = "10.1.0.0/16"
    }
    prod = {
      instance_type = "t3.medium"
      min_size      = 3
      max_size      = 10
      desired_size  = 3
      cidr_block    = "10.2.0.0/16"
    }
  }

  current_config = local.environment_config[local.environment]
}

# VPC for the workspace
resource "aws_vpc" "workspace_vpc" {
  cidr_block           = local.current_config.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.environment}-vpc"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "workspace_igw" {
  vpc_id = aws_vpc.workspace_vpc.id

  tags = {
    Name        = "${local.environment}-igw"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Public Subnets (multiple for ALB requirement)
resource "aws_subnet" "workspace_public_subnet" {
  count = 2

  vpc_id                  = aws_vpc.workspace_vpc.id
  cidr_block              = cidrsubnet(local.current_config.cidr_block, 8, count.index + 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${local.environment}-public-subnet-${count.index + 1}"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Private Subnets
resource "aws_subnet" "workspace_private_subnet" {
  count = 2

  vpc_id            = aws_vpc.workspace_vpc.id
  cidr_block        = cidrsubnet(local.current_config.cidr_block, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${local.environment}-private-subnet-${count.index + 1}"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "workspace_public_rt" {
  vpc_id = aws_vpc.workspace_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.workspace_igw.id
  }

  tags = {
    Name        = "${local.environment}-public-rt"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "workspace_public_rta" {
  count = length(aws_subnet.workspace_public_subnet)

  subnet_id      = aws_subnet.workspace_public_subnet[count.index].id
  route_table_id = aws_route_table.workspace_public_rt.id
}

# Security Group for Web Servers
resource "aws_security_group" "workspace_web_sg" {
  name_prefix = "${local.environment}-web-sg"
  vpc_id      = aws_vpc.workspace_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.environment}-web-sg"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Launch Template
resource "aws_launch_template" "workspace_web_lt" {
  name_prefix   = "${local.environment}-web-lt"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = local.current_config.instance_type

  vpc_security_group_ids = [aws_security_group.workspace_web_sg.id]

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = local.environment
    workspace   = local.workspace_name
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${local.environment}-web-server"
      Environment = local.environment
      Workspace   = local.workspace_name
      ManagedBy   = "Terraform"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "workspace_web_asg" {
  name                = "${local.environment}-web-asg"
  vpc_zone_identifier = aws_subnet.workspace_public_subnet[*].id
  target_group_arns   = [aws_lb_target_group.workspace_web_tg.arn]
  health_check_type   = "ELB"

  min_size         = local.current_config.min_size
  max_size         = local.current_config.max_size
  desired_capacity = local.current_config.desired_size

  launch_template {
    id      = aws_launch_template.workspace_web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.environment}-web-asg"
    propagate_at_launch = false
  }

  tag {
    key                 = "Environment"
    value               = local.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Workspace"
    value               = local.workspace_name
    propagate_at_launch = true
  }

  tag {
    key                 = "ManagedBy"
    value               = "Terraform"
    propagate_at_launch = true
  }
}

# Application Load Balancer
resource "aws_lb" "workspace_web_lb" {
  name               = "${local.environment}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.workspace_web_sg.id]
  subnets            = aws_subnet.workspace_public_subnet[*].id

  enable_deletion_protection = false

  tags = {
    Name        = "${local.environment}-web-lb"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Target Group
resource "aws_lb_target_group" "workspace_web_tg" {
  name     = "${local.environment}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.workspace_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = "${local.environment}-web-tg"
    Environment = local.environment
    Workspace   = local.workspace_name
    ManagedBy   = "Terraform"
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "workspace_web_listener" {
  load_balancer_arn = aws_lb.workspace_web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.workspace_web_tg.arn
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
