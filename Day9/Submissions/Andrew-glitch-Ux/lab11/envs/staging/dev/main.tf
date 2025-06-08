provider "aws" {
  region = var.region
}

module "web_server" {
  source        = "../../modules/web-server"
  region        = var.region
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  instance_type = var.instance_type
  ami_id        = var.ami_id
  env           = var.env
  tags          = var.tags
}
