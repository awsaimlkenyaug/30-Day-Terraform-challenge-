module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  app_name             = var.app_name
}


module "alb" {
  source     = "../../modules/alb"
  app_name   = var.app_name
  alb_sg_id  = module.asg.asg_sg_id 
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
}

module "asg" {
  source                   = "../../modules/asg"
  ami_id                   = var.ami_id
  instance_type            = var.instance_type
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnet_ids
  instance_sg_id           =module.asg.asg_sg_id
  target_group_arn         = module.alb.target_group_arn
  user_data_enabled        = var.user_data_enabled
  ssh_ingress_cidr_blocks  = var.ssh_ingress_cidr_blocks
  http_ingress_cidr_blocks = var.http_ingress_cidr_blocks
  egress_cidr_blocks       = var.egress_cidr_blocks
  app_name                 = var.app_name
  desired_capacity         = var.desired_capacity
  min_size                 = var.min_size
  max_size                 = var.max_size
}

