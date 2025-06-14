terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    bucket         = "tf-backend-lab15"
    key            = "envs/lab15/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "tf-table-lab15"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# Securely load decrypted secrets from local file
locals {
  db_creds = jsondecode(file("${path.module}/secrets.json"))
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block         = var.vpc_cidr_block
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  availability_zones     = var.availability_zones
  environment            = var.environment
  db_port                = var.db_port
  db_allowed_cidr_blocks = var.allowed_cidr_blocks
  egress_cidr_blocks     = var.egress_cidr_blocks
}

module "db" {
  source = "./modules/db"

  name                = var.db_name
  username            = local.db_creds.username   # <-- from decrypted secrets.json
  password            = local.db_creds.password   # <-- from decrypted secrets.json
  instance_class      = var.db_instance_class
  allocated_storage   = var.db_allocated_storage
  engine              = var.db_engine
  engine_version      = var.db_engine_version
  port                = var.db_port
  security_group_ids  = [module.vpc.db_sg_id]
  subnet_ids          = module.vpc.private_subnet_ids
  environment         = var.environment
}
