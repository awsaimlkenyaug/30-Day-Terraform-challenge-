provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"

  name                 = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnets       = var.public_subnets
  tags                 = var.tags
}

module "alb" {
  source = "../modules/alb"

  name                        = var.name
  subnet_ids                  = module.vpc.public_subnet_ids
  internal                    = var.internal
  enable_deletion_protection  = var.enable_deletion_protection

  target_group_name           = var.target_group_name
  target_group_port           = var.target_group_port
  target_group_protocol       = var.target_group_protocol
  vpc_id                      = module.vpc.vpc_id
  target_type                 = var.target_type

  health_check_interval       = var.health_check_interval
  health_check_path           = var.health_check_path
  health_check_protocol       = var.health_check_protocol
  health_check_timeout        = var.health_check_timeout
  healthy_threshold           = var.healthy_threshold
  unhealthy_threshold         = var.unhealthy_threshold
  health_check_matcher        = var.health_check_matcher

  listener_port               = var.listener_port
  listener_protocol           = var.listener_protocol

  alb_ingress_port            = var.alb_ingress_port
  alb_ingress_cidr_blocks     = var.alb_ingress_cidr_blocks
  alb_egress_cidr_blocks      = var.alb_egress_cidr_blocks

  tags                        = var.tags
}

module "asg" {
  source = "../modules/asg"

  name                      = var.asg_name
  ami_id                    = var.ami_id
  instance_type             = var.instance_type
  user_data                 = var.user_data
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  subnet_ids                = module.vpc.public_subnet_ids
  asg_security_group_ids    = [module.alb.alb_security_group_id]  # <- Use alb module SG output here!
  health_check_grace_period = var.health_check_grace_period
  target_group_arns         = [module.alb.target_group_arn]
  tags                      = var.tags
}
