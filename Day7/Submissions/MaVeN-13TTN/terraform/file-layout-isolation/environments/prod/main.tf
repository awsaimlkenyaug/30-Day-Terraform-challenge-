# Production Environment Configuration

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "maven-13ttn-terraform-state-bucket"
    key            = "file-layout-isolation/prod/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
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

# Local values
locals {
  environment = "prod"

  vpc_cidr = "10.2.0.0/16"
  public_subnet_cidrs = [
    "10.2.1.0/24",
    "10.2.2.0/24",
    "10.2.3.0/24"
  ]
  private_subnet_cidrs = [
    "10.2.101.0/24",
    "10.2.102.0/24",
    "10.2.103.0/24"
  ]

  # Environment-specific settings
  instance_type    = "t3.medium"
  min_size         = 3
  max_size         = 12
  desired_capacity = 3

  common_tags = merge(
    var.common_tags,
    {
      Environment = local.environment
      Project     = var.project_name
    }
  )
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  environment          = local.environment
  cidr_block           = local.vpc_cidr
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway

  common_tags = local.common_tags
}

# Security Groups Module
module "security_groups" {
  source = "../../modules/security-groups"

  environment        = local.environment
  vpc_id             = module.vpc.vpc_id
  create_database_sg = var.create_database_sg

  # Production-specific security group rules
  ingress_rules = [
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # SSH access removed for production security
  ]

  common_tags = local.common_tags
}

# Load Balancer Module
module "load_balancer" {
  source = "../../modules/load-balancer"

  environment        = local.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security_groups.web_security_group_id]

  # Production-specific LB settings
  enable_deletion_protection = var.enable_deletion_protection
  enable_access_logs         = true
  access_logs_bucket         = var.access_logs_bucket
  access_logs_prefix         = "prod-alb-logs"

  # HTTPS configuration
  listener_protocol     = var.enable_https ? "HTTPS" : "HTTP"
  listener_port         = var.enable_https ? 443 : 80
  certificate_arn       = var.certificate_arn
  enable_https_redirect = var.enable_https

  common_tags = local.common_tags
}

# Compute Module
module "compute" {
  source = "../../modules/compute"

  environment        = local.environment
  project_name       = var.project_name
  application_name   = var.application_name
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = local.instance_type
  key_name           = var.key_name
  security_group_ids = [module.security_groups.web_security_group_id]
  subnet_ids         = var.use_private_subnets ? module.vpc.private_subnet_ids : module.vpc.public_subnet_ids
  target_group_arns  = [module.load_balancer.target_group_arn]

  # Auto Scaling settings
  min_size         = local.min_size
  max_size         = local.max_size
  desired_capacity = local.desired_capacity

  # Production-specific settings
  enable_autoscaling = true
  cpu_high_threshold = 80
  cpu_low_threshold  = 30

  # Enhanced monitoring for production
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances"
  ]

  common_tags = local.common_tags
}
