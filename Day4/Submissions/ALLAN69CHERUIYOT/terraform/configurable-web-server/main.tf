# --- Variables Definition ---
# These variables allow you to make your deployment configurable.
# You can define their default values here or provide them via terraform.tfvars,
# or command line with -var="name=value".

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1" # Default to N. Virginia
}

variable "instance_type" {
  description = "The EC2 instance type for the web server."
  type        = string
  default     = "t2.micro" # Free-tier eligible
}

variable "server_name" {
  description = "A name for the web server instance."
  type        = string
  default     = "Day4-ConfigurableWebServer"
}

variable "ami_filter_name" {
  description = "Filter name for the Amazon Linux AMI."
  type        = string
  default     = "al2023-ami-2023.*-x86_64"
}

variable "web_server_port" {
  description = "The port for web traffic (HTTP)."
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "The port for SSH access."
  type        = number
  default     = 22
}

variable "web_content" {
  description = "The content to display on the web server's index.html."
  type        = string
  default     = "<h1>Hello from Day 4 Configurable Web Server by ALLAN69CHERUIYOT!</h1>"
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

# Get information about the default VPC in the chosen region
data "aws_vpc" "default" {
  default = true
}

# --- Resources ---
# Create a Security Group to allow web traffic (HTTP) and SSH
resource "aws_security_group" "configurable_web_server_sg" {
  name        = "${var.server_name}-sg"
  description = "Allow HTTP and SSH inbound traffic for configurable web server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
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
    Name = "${var.server_name}-SG"
  }
}

# Create the EC2 instance for the configurable web server
resource "aws_instance" "configurable_web_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.configurable_web_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "${var.web_content}" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = var.server_name
  }
}

# --- Outputs ---
# Output the public IP address of the configurable web server
output "configurable_web_server_public_ip" {
  value       = aws_instance.configurable_web_server.public_ip
  description = "The public IP address of the configurable web server."
}