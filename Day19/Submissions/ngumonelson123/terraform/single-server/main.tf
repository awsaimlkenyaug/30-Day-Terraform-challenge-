# terraform {
#   backend "remote" {
#     organization = "nelson_hcp"

#     workspaces {
#       name = "day19-single-server"
#     }
#   }
# }

# provider "aws" {
#   region = "us-east-1"
# }

# # Fetch latest Amazon Linux 2 AMI
# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["137112412989"] # Amazon
# }

# # Create VPC
# resource "aws_vpc" "main" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "day19-vpc"
#   }
# }

# # Create Subnet
# resource "aws_subnet" "main" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = "10.0.1.0/24"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "day19-subnet"
#   }
# }

# # Security Group to allow SSH and HTTP
# resource "aws_security_group" "sg" {
#   name        = "day19-sg"
#   description = "Allow SSH and HTTP"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "day19-security-group"
#   }
# }

# # EC2 Instance
# resource "aws_instance" "example" {
#   ami                    = data.aws_ami.amazon_linux.id
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.main.id
#   vpc_security_group_ids = [aws_security_group.sg.id]

#   tags = {
#     Name = "Day19Server"
#   }
# }
