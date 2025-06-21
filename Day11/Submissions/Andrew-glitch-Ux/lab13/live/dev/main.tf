provider "aws" {
  region = var.region
}

module "vpc" {
  source      = "../../modules/vpc"
  name        = var.name
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  route_cidr  = var.route_cidr
  az          = var.az
}

module "web_server" {
  source          = "../../modules/web-server"
  name            = var.name
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  ingress_rules   = var.ingress_rules
  egress_rules    = var.egress_rules
  deploy_instance = var.deploy_instance
}
