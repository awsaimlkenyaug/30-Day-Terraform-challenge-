terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

# Generate a random ID to make the S3 bucket name unique
resource "random_id" "randomness" {
  byte_length = 4
}

# Create an S3 bucket (Lab 3: Terraform Provider Block)
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "nelson-bucket-${random_id.randomness.hex}"
  force_destroy = true

  tags = {
    Name    = "Nelsons Demo Bucket"   # <-- Removed apostrophe to fix InvalidTag error
    Project = "Terraform Lab Day 3"
  }
}

# Set ownership controls for the S3 bucket
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Create a VPC (Lab 4: Resource Block)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main VPC"
  }
}

# Create a Security Group that allows HTTPS traffic
resource "aws_security_group" "web_sg" {
  name        = "web_server_https_sg"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTPS from the internet"
    from_port   = 443
    to_port     = 443
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
    Name = "HTTPS Security Group"
  }
}
