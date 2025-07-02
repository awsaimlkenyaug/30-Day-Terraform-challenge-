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
    Project     = "30-day-terraform-challenge"
  })

  # Conditional deployment flags
  deploy_alb        = var.environment != "dev" || var.force_alb_in_dev
  deploy_monitoring = var.environment != "dev"
  deploy_backup     = var.environment == "production"
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

# Conditional ALB deployment
module "alb" {
  count = local.deploy_alb ? 1 : 0

  source            = "./modules/alb"
  environment       = var.environment
  name_prefix       = local.name_prefix
  security_group_id = module.security_group.security_group_id
  instance_ids      = module.ec2.instance_ids
  tags              = local.common_tags
  enable_stickiness = var.environment == "production"
}

# Conditional CloudWatch monitoring for non-dev environments
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count = local.deploy_monitoring ? 1 : 0

  alarm_name          = "${local.name_prefix}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = var.environment == "production" ? 70 : 80
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    InstanceId = module.ec2.instance_ids[0]
  }
}

# Conditional backup for production environment
resource "aws_backup_plan" "production" {
  count = local.deploy_backup ? 1 : 0

  name = "${local.name_prefix}-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = "Default"
    schedule          = "cron(0 12 * * ? *)"

    lifecycle {
      delete_after = 14
    }
  }

  tags = local.common_tags
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.ec2.public_dns
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = local.deploy_alb ? module.alb[0].alb_dns_name : "ALB not deployed in this environment"
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "instance_details" {
  description = "Details of all EC2 instances"
  value = {
    instance_ids = module.ec2.instance_ids
    public_ips   = module.ec2.public_ips
    private_ips  = module.ec2.private_ips
  }
}