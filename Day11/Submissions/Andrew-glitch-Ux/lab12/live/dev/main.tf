provider "aws" {
  region = var.region
}

module "web_server" {
  source         = "../../modules/web-server"

  name           = var.name
  region         = var.region
  vpc_cidr       = var.vpc_cidr
  subnet_cidr    = var.subnet_cidr
  az             = var.az
  ami            = var.ami
  instance_type  = var.instance_type
  route_cidr     = var.route_cidr
  ingress_rules  = var.ingress_rules
  egress_rules   = var.egress_rules
  deploy_instance = var.deploy_instance
}
