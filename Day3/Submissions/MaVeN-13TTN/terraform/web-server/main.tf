# Day 3 Lab 04: Web Server Deployment
# Web Server with User Data Script

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
  region = "us-east-1"

  # Optional: Add default tags to all resources
  default_tags {
    tags = {
      Environment = "learning"
      Project     = "30-day-terraform-challenge"
      Day         = "3"
      Owner       = "MaVeN-13TTN"
      Type        = "web-server"
    }
  }
}

# Data Sources
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
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

# Security Group for Web Server - allows HTTP and SSH
resource "aws_security_group" "web_server_sg" {
  name_prefix = "web-server-sg-"
  description = "Security group for web server - HTTP and SSH access"
  vpc_id      = data.aws_vpc.default.id

  # Inbound rule - SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule - HTTP access
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "web-server-security-group"
  }
}

# Key Pair for Web Server
resource "aws_key_pair" "web_server_key" {
  key_name   = "web-server-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name = "web-server-key-pair"
  }
}

# User Data Script to install and configure Apache
locals {
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    
    # Create a simple HTML page
    cat <<HTML > /var/www/html/index.html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Day 3 - Web Server Deployment</title>
        <style>
            body { font-family: Arial, sans-serif; margin: 40px; background-color: #f0f8ff; }
            .container { max-width: 800px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
            h1 { color: #2c3e50; text-align: center; }
            .info { background-color: #e8f4fd; padding: 15px; border-radius: 5px; margin: 20px 0; }
            .success { color: #27ae60; font-weight: bold; }
            .terraform-logo { text-align: center; font-size: 2em; color: #623ce4; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="terraform-logo">🚀 Terraform</div>
            <h1>Welcome to Day 3 Web Server!</h1>
            <div class="info">
                <h3>Deployment Information:</h3>
                <ul>
                    <li><strong>Challenge:</strong> 30-Day Terraform Challenge</li>
                    <li><strong>Day:</strong> 3 - Deploying Basic Infrastructure</li>
                    <li><strong>Server Type:</strong> Web Server with Apache</li>
                    <li><strong>Instance:</strong> EC2 t3.micro</li>
                    <li><strong>OS:</strong> Amazon Linux 2</li>
                    <li><strong>Deployed by:</strong> MaVeN-13TTN</li>
                    <li><strong>Date:</strong> $(date)</li>
                </ul>
            </div>
            <div class="info">
                <h3>Server Details:</h3>
                <ul>
                    <li><strong>Hostname:</strong> $(hostname)</li>
                    <li><strong>Private IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</li>
                    <li><strong>Public IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)</li>
                    <li><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</li>
                </ul>
            </div>
            <p class="success">🎉 Web server successfully deployed using Terraform!</p>
            <p><em>This demonstrates Infrastructure as Code (IaC) principles in action.</em></p>
        </div>
    </body>
    </html>
HTML

    # Set proper permissions
    chown apache:apache /var/www/html/index.html
    chmod 644 /var/www/html/index.html
    
    # Log deployment completion
    echo "Web server setup completed at $(date)" >> /var/log/user-data.log
  EOF
}

# EC2 Instance for Web Server
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.web_server_key.key_name
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  subnet_id              = data.aws_subnet.default.id

  # Associate public IP
  associate_public_ip_address = true

  # User data script to install and configure Apache
  user_data = base64encode(local.user_data)

  # Instance metadata options (security best practice)
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Root block device configuration
  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  tags = {
    Name = "web-server-day3"
  }
}

# Output values to display important information
output "instance_id" {
  description = "ID of the EC2 web server instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}

output "web_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_connection_command" {
  description = "SSH command to connect to the web server"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_ip}"
}
