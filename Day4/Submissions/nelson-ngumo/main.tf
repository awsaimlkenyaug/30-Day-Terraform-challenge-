terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# Data sources
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Region      = data.aws_region.current.name
    Environment = "day4"
  }
}

# Subnet
resource "aws_subnet" "variables-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.variables_sub_cidr
  availability_zone       = var.variables_sub_az
  map_public_ip_on_launch = var.variables_sub_auto_ip
  tags = {
    Name = "sub-variables-${var.variables_sub_az}"
  }
}

# Security Group
resource "aws_security_group" "vpc-ping" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (Configurable)
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.ubuntu_22_04.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.variables-subnet.id
  vpc_security_group_ids      = [aws_security_group.vpc-ping.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              echo "<h1>Terraform Day 4 - Web Server Deployed!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ConfigurableWebServer"
  }
}
