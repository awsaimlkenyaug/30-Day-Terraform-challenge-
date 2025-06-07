# --- Variables Definition ---
# These variables allow you to configure your scaled web application.

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The EC2 instance type for each web server in the cluster."
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of web servers to deploy in the cluster behind the Load Balancer."
  type        = number
  default     = 2 # Deploy 2 instances by default
}

variable "app_name_prefix" {
  description = "A prefix for the names of all application resources (ALB, instances, SGs)."
  type        = string
  default     = "Day5-ScaledWebApp"
}

variable "ami_filter_name" {
  description = "Filter name for the Amazon Linux AMI."
  type        = string
  default     = "al2023-ami-2023.*-x86_64"
}

variable "web_server_port" {
  description = "The port for web traffic (HTTP) on the instances (target group port)."
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "The port for SSH access to the instances."
  type        = number
  default     = 22
}

variable "web_content_base" {
  description = "Base content for the web server's index.html. Will include instance number."
  type        = string
  default     = "<h1>Hello from Day 5 Scaled Web Server Instance "
}

# --- AWS Provider Configuration ---
provider "aws" {
  region = var.aws_region
}

# --- Data Sources ---
# Dynamically find the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get information about the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get IDs of all public subnets in the default VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}


# --- Resources ---

# 1. Security Group for the Load Balancer
# This SG allows inbound HTTP traffic from anywhere.
resource "aws_security_group" "alb_sg" {
  name        = "${var.app_name_prefix}-ALB-SG"
  description = "Allow HTTP inbound traffic to ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name_prefix}-ALB-SG"
  }
}

# 2. Security Group for the EC2 Instances
# This SG allows inbound HTTP traffic ONLY from the ALB's security group, and SSH from anywhere.
resource "aws_security_group" "web_server_sg" {
  name        = "${var.app_name_prefix}-WebServer-SG"
  description = "Allow HTTP from ALB and SSH to web servers"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    # Allow HTTP only from the ALB's security group
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (for management)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name_prefix}-WebServer-SG"
  }
}

# 3. Application Load Balancer (ALB)
resource "aws_lb" "application_lb" {
  name               = "${var.app_name_prefix}-ALB"
  internal           = false # Set to true for internal LB
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.public.ids # Deploy ALB across public subnets

  enable_deletion_protection = false # Set to true in production

  tags = {
    Name = "${var.app_name_prefix}-ALB"
  }
}

# 4. ALB Target Group
# Defines how the ALB routes requests to registered targets (EC2 instances).
resource "aws_lb_target_group" "web_target_group" {
  name     = "${var.app_name_prefix}-TG"
  port     = var.web_server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/" # Check the root path of the web server
    protocol            = "HTTP"
    matcher             = "200" # Expect HTTP 200 OK
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.app_name_prefix}-TG"
  }
}

# 5. ALB Listener
# Listens for incoming traffic on the ALB and forwards it to the target group.
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}


# 6. EC2 Instances (Web Servers)
# This resource creates multiple EC2 instances, similar to Day 4, but now
# explicitly associates them with the ALB's target group.
resource "aws_instance" "web_servers" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server_sg.id] # Attach the new web server SG

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "${var.web_content_base}${count.index + 1} by ALLAN69CHERUIYOT (via ALB)!</h1>" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.app_name_prefix}-Instance-${count.index + 1}"
  }
}

# 7. Register EC2 Instances with the Target Group
# This block ensures that each EC2 instance created by 'aws_instance.web_servers'
# is registered as a target in 'aws_lb_target_group.web_target_group'.
resource "aws_lb_target_group_attachment" "web_target_group_attachments" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.web_servers[count.index].id
  port             = var.web_server_port # Specify the port on the instance itself
}


# --- Outputs ---
# Output the DNS name of the Load Balancer, which is the entry point for your application.
output "application_lb_dns_name" {
  value       = aws_lb.application_lb.dns_name
  description = "The DNS name of the Application Load Balancer."
}

# Output the public IPs of the backend instances (for reference, though traffic should go via ALB)
output "backend_instance_public_ips" {
  value       = aws_instance.web_servers[*].public_ip
  description = "The public IP addresses of the backend web servers."
}