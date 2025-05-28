# Day 3 Lab 03: AWS Terraform Provider Configuration
# Single Server Deployment

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
    }
  }
}

# Lab 03: Understanding Provider Blocks
# The provider block configures the named provider (AWS in this case)
# - source: specifies where to download the provider from
# - version: constrains which provider versions are acceptable
# - region: AWS region where resources will be created
# - default_tags: tags applied to all resources by default

# Lab 05: Data Sources - Query existing AWS resources
# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get the default subnet
data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  default_for_az    = true
}

# Data source to get the latest Amazon Linux 2 AMI
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

# Lab 04: Resource Blocks - Security Group
resource "aws_security_group" "single_server_sg" {
  name_prefix = "single-server-sg-"
  description = "Security group for single server - SSH access only"
  vpc_id      = data.aws_vpc.default.id

  # Inbound rule - SSH access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Note: In production, restrict to your IP
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
    Name = "single-server-security-group"
  }
}

# Lab 04: Resource Blocks - Key Pair
resource "aws_key_pair" "single_server_key" {
  key_name   = "single-server-key"
  public_key = file("~/.ssh/id_rsa.pub") # You'll need to create this key pair

  tags = {
    Name = "single-server-key-pair"
  }
}

# Lab 04: Resource Blocks - EC2 Instance
resource "aws_instance" "single_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.single_server_key.key_name
  vpc_security_group_ids = [aws_security_group.single_server_sg.id]
  subnet_id              = data.aws_subnet.default.id

  # Associate public IP
  associate_public_ip_address = true

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
    Name = "single-server-day3"
  }
}

# Output values to display important information
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.single_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.single_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.single_server.public_dns
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.single_server.public_ip}"
}
