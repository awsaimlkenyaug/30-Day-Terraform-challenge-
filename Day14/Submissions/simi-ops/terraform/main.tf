terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary provider for main region
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

# Secondary provider for backup region
provider "aws" {
  alias  = "backup"
  region = var.backup_region

  default_tags {
    tags = merge(var.tags, {
      Region = "backup"
    })
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

data "aws_ami" "backup" {
  count = var.environment == "production" ? 1 : 0

  provider    = aws.backup
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

# Auto Scaling Group deployment
module "asg" {
  source                = "./modules/asg"
  environment           = var.environment
  name_prefix           = local.name_prefix
  ami_id                = data.aws_ami.amazon_linux.id
  instance_type         = var.instance_type[var.environment]
  security_group_id     = module.security_group.security_group_id
  min_size              = var.min_size[var.environment]
  max_size              = var.max_size[var.environment]
  desired_capacity      = var.min_size[var.environment]
  target_group_arns     = local.deploy_alb ? [module.alb[0].target_group_arn] : []
  instance_profile_name = module.secrets.instance_profile_name
  secret_name           = module.secrets.secret_name
  tags                  = local.common_tags

  depends_on = [module.alb, module.secrets]
}

# Conditional ALB deployment
module "alb" {
  count = local.deploy_alb ? 1 : 0

  source            = "./modules/alb"
  environment       = var.environment
  name_prefix       = local.name_prefix
  security_group_id = module.security_group.security_group_id
  instance_ids      = []
  tags              = local.common_tags
  enable_stickiness = var.environment == "production"
}

# Secrets management
module "secrets" {
  source = "./modules/secrets"

  environment       = var.environment
  name_prefix       = local.name_prefix
  database_password = var.database_password
  api_key           = var.api_key
  jwt_secret        = var.jwt_secret
  tags              = local.common_tags
}

# Backup region deployment (production only)
module "backup_asg" {
  count = var.environment == "production" ? 1 : 0

  source                = "./modules/asg"
  providers             = { aws = aws.backup }
  environment           = var.environment
  name_prefix           = "${local.name_prefix}-backup"
  ami_id                = data.aws_ami.backup[0].id
  instance_type         = var.instance_type[var.environment]
  security_group_id     = module.backup_security_group[0].security_group_id
  min_size              = 1
  max_size              = 2
  desired_capacity      = 1
  target_group_arns     = []
  instance_profile_name = module.backup_secrets[0].instance_profile_name
  secret_name           = module.backup_secrets[0].secret_name
  tags                  = merge(local.common_tags, { Region = "backup" })

  depends_on = [module.backup_secrets]
}

module "backup_security_group" {
  count = var.environment == "production" ? 1 : 0

  source      = "./modules/security_group"
  providers   = { aws = aws.backup }
  environment = var.environment
  name_prefix = "${local.name_prefix}-backup"
  tags        = merge(local.common_tags, { Region = "backup" })
}

module "backup_secrets" {
  count = var.environment == "production" ? 1 : 0

  source            = "./modules/secrets"
  providers         = { aws = aws.backup }
  environment       = var.environment
  name_prefix       = "${local.name_prefix}-backup"
  database_password = var.database_password
  api_key           = var.api_key
  jwt_secret        = var.jwt_secret
  tags              = merge(local.common_tags, { Region = "backup" })
}





output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = local.deploy_alb ? module.alb[0].alb_dns_name : "ALB not deployed in this environment"
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "asg_details" {
  description = "Auto Scaling Group details"
  value = {
    asg_name        = module.asg.asg_name
    asg_arn         = module.asg.asg_arn
    launch_template = module.asg.launch_template_name
  }
}

output "secrets_arn" {
  description = "ARN of the secrets manager secret"
  value       = module.secrets.secret_arn
  sensitive   = true
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile for secrets access"
  value       = module.secrets.instance_profile_name
}