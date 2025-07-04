terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Using us-east-1 for Free Tier eligibility
}

module "web" {
  source             = "../modules/ec2-web-module/v2.0.0"
  name_prefix        = "dkb-web"
  environment        = var.environment
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  ssh_key_name       = var.ssh_key_name
  instance_count     = var.instance_count
  enable_monitoring  = var.enable_monitoring
}

# Only create load balancer in production
resource "aws_lb" "this" {
  count = var.environment == "prod" ? 1 : 0
  
  name               = "${var.environment}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = [var.subnet_id]
  
  tags = {
    Name        = "${var.environment}-web-lb"
    Environment = var.environment
  }
}

output "web_public_ip" {
  value = module.web.public_ip
}

output "load_balancer_dns" {
  value = var.environment == "prod" ? aws_lb.this[0].dns_name : null
}