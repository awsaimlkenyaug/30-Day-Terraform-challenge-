provider "aws" {
  region = var.deploy_to_eu ? var.eu_region : var.us_region

  default_tags {
    tags = {
      Owner     = "team-foo"
      ManagedBy = "Terraform"
    }
  }
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  name       = var.vpc_name
}

module "iam_users" {
  for_each   = toset(var.user_names)
  source     = "./modules/iam-user"
  user_name  = each.value
}

module "network" {
  source = "./modules/network"

  vpc_id = module.vpc.vpc_id

  subnets = var.subnets

  extra_tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}
