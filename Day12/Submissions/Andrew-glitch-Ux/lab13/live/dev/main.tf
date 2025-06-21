module "vpc" {
  source             = "../../modules/vpc"
  region             = var.region
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnet_cidr = var.public_subnet_cidr
}

module "web_server" {
  source            = "../../modules/web-server"
  region            = var.region
  subnet_id         = module.vpc.public_subnet_id
  vpc_id            = module.vpc.vpc_id

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  user_data_enabled = true

  count             = var.deploy_web_server ? 1 : 0
}
