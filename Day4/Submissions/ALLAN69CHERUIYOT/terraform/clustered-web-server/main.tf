# --- Variables Definition ---
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
  description = "The number of web servers to deploy in the cluster."
  type        = number
  default     = 2 # Deploy 2 instances by default for the cluster
}

variable "server_name_prefix" {
  description = "A prefix for the names of the web server instances in the cluster."
  type        = string
  default     = "Day4-ClusteredWebServer"
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

variable "web_content_base" {
  description = "Base content for the web server's index.html. Will include instance number."
  type        = string
  default     = "<h1>Hello from Day 4 Clustered Web Server Instance "
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

# --- Resources ---
# Create a Security Group to allow web traffic (HTTP) and SSH
resource "aws_security_group" "clustered_web_server_sg" {
  name        = "${var.server_name_prefix}-sg"
  description = "Allow HTTP and SSH inbound traffic for clustered web servers"
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
    Name = "${var.server_name_prefix}-SG"
  }
}

# Create multiple EC2 instances for the clustered web server
resource "aws_instance" "clustered_web_servers" {
  count                  = var.instance_count # This creates 'instance_count' number of instances
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.clustered_web_server_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "${var.web_content_base}${count.index + 1} by ALLAN69CHERUIYOT!</h1>" | sudo tee /var/www/html/index.html
              EOF
  # Using count.index to make each web server's content unique

  tags = {
    Name = "${var.server_name_prefix}-${count.index + 1}" # Unique name for each instance
  }
}

# --- Outputs ---
# Output the public IP addresses of all clustered web servers
output "clustered_web_servers_public_ips" {
  value       = aws_instance.clustered_web_servers[*].public_ip
  description = "The public IP addresses of all clustered web servers."
}