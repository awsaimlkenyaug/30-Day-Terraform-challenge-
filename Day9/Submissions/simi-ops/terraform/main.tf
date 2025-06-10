terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

locals {
  name_prefix = "${var.environment}-web"

  common_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
  })
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

module "security_group" {
  source = "./modules/security_group"

  environment = var.environment
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "ec2" {
  source            = "./modules/ec2"
  environment       = var.environment
  name_prefix       = local.name_prefix
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = var.instance_type[var.environment]
  security_group_id = module.security_group.security_group_id
  tags              = local.common_tags
}

module "alb" {
  source            = "./modules/alb"
  environment       = var.environment
  name_prefix       = local.name_prefix
  security_group_id = module.security_group.security_group_id
  instance_id       = module.ec2.instance_id
  tags              = local.common_tags
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.public_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.ec2.public_dns
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}