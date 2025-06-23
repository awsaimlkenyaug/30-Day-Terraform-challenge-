module "network_primary" {
  source   = "./modules/network"
  providers = {
    aws = aws
  }
  region              = var.primary_region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.primary_vpc_cidr
  public_subnet_cidr  = var.primary_public_subnet_cidr
  availability_zone   = var.primary_az
}

module "network_secondary" {
  source   = "./modules/network"
  providers = {
    aws = aws.secondary
  }
  region              = var.secondary_region
  vpc_name            = var.vpc_name
  vpc_cidr            = var.secondary_vpc_cidr
  public_subnet_cidr  = var.secondary_public_subnet_cidr
  availability_zone   = var.secondary_az
}

module "compute_primary" {
  source        = "./modules/compute"
  providers = {
    aws = aws
  }
   ami_id        = var.ami_id_primary
  instance_type = var.instance_type
  vpc_id        = module.network_primary.vpc_id
  subnet_id     = module.network_primary.subnet_id
  instance_name = var.primary_instance_name
}

module "compute_secondary" {
  source        = "./modules/compute"
  providers = {
    aws = aws.secondary
  }
   ami_id        = var.ami_id_secondary
  instance_type = var.instance_type
  vpc_id        = module.network_secondary.vpc_id
  subnet_id     = module.network_secondary.subnet_id
  instance_name = var.secondary_instance_name
}