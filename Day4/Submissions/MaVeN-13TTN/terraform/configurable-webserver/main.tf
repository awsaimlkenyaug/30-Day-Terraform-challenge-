# Day 4 - Configurable Web Server
# Uses variables to make the infrastructure configurable and reusable

# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider with region
provider "aws" {
  region = var.aws_region

  # Default tags applied to all resources
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      Day         = "4"
      Owner       = var.owner
      Type        = "configurable-web-server"
      CreatedBy   = "Terraform"
    }
  }
}

# Data Sources - fetch existing AWS resources
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = var.availability_zone
  default_for_az    = true
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

# Security Group for Configurable Web Server
resource "aws_security_group" "configurable_web_sg" {
  name_prefix = "${var.server_name}-sg-"
  description = "Security group for configurable web server"
  vpc_id      = data.aws_vpc.default.id

  # SSH access - configurable
  dynamic "ingress" {
    for_each = var.enable_ssh ? [1] : []
    content {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_cidr_blocks
    }
  }

  # HTTP access - configurable port
  ingress {
    description = "HTTP"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = var.http_cidr_blocks
  }

  # HTTPS access - optional
  dynamic "ingress" {
    for_each = var.enable_https ? [1] : []
    content {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.http_cidr_blocks
    }
  }

  # Outbound rules - Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.server_name}-security-group"
  }
}

# Key Pair for EC2 access (conditional)
resource "aws_key_pair" "web_server_key" {
  count      = var.enable_ssh && var.create_key_pair ? 1 : 0
  key_name   = "${var.server_name}-key"
  public_key = file(var.public_key_path)

  tags = {
    Name = "${var.server_name}-key-pair"
  }
}

# User Data Script - configurable web server setup
locals {
  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
    server_name = var.server_name
    custom_html = var.custom_html_content
    enable_ssl  = var.enable_https
    environment = var.environment
    owner       = var.owner
  })
}

# EC2 Instance - Configurable Web Server
resource "aws_instance" "configurable_web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.enable_ssh && var.create_key_pair ? aws_key_pair.web_server_key[0].key_name : var.existing_key_name

  vpc_security_group_ids = [aws_security_group.configurable_web_sg.id]
  subnet_id              = data.aws_subnet.default.id

  # Enable detailed monitoring if specified
  monitoring = var.enable_detailed_monitoring

  # EBS optimization
  ebs_optimized = var.enable_ebs_optimization

  # Root block device configuration
  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    encrypted             = var.enable_encryption
    delete_on_termination = true

    tags = {
      Name = "${var.server_name}-root-volume"
    }
  }

  # User data for web server configuration
  user_data = base64encode(local.user_data)

  # Metadata options for enhanced security
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required" # IMDSv2
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = var.server_name
  }

  # Wait for instance to be ready
  lifecycle {
    create_before_destroy = true
  }
}

# Elastic IP (optional)
resource "aws_eip" "web_server_eip" {
  count    = var.allocate_eip ? 1 : 0
  instance = aws_instance.configurable_web_server.id
  domain   = "vpc"

  tags = {
    Name = "${var.server_name}-eip"
  }

  depends_on = [aws_instance.configurable_web_server]
}
