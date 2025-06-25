# Staging Environment Configuration

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
    key            = "file-layout-isolation/staging/terraform.tfstate"
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
  environment = "staging"

  vpc_cidr = "10.1.0.0/16"
  public_subnet_cidrs = [
    "10.1.1.0/24",
    "10.1.2.0/24"
  ]
  private_subnet_cidrs = [
    "10.1.101.0/24",
    "10.1.102.0/24"
  ]

  # Environment-specific settings
  instance_type    = "t3.small"
  min_size         = 2
  max_size         = 6
  desired_capacity = 2

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

  common_tags = local.common_tags
}

# Load Balancer Module
module "load_balancer" {
  source = "../../modules/load-balancer"

  environment        = local.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.security_groups.web_security_group_id]

  # Staging-specific LB settings
  enable_deletion_protection = false
  enable_access_logs         = true
  access_logs_bucket         = var.access_logs_bucket
  access_logs_prefix         = "staging-alb-logs"

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
  subnet_ids         = module.vpc.public_subnet_ids
  target_group_arns  = [module.load_balancer.target_group_arn]

  # Auto Scaling settings
  min_size         = local.min_size
  max_size         = local.max_size
  desired_capacity = local.desired_capacity

  # Staging-specific settings
  enable_autoscaling = true
  cpu_high_threshold = 75
  cpu_low_threshold  = 25

  common_tags = local.common_tags
}
