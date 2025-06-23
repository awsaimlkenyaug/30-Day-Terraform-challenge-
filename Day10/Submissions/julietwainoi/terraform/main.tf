provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

module "ec2_us_east" {
  source    = "./modules/ec2"
  providers = { aws = aws.us_east }
  count     = var.deploy_us_east ? 1 : 0

  ami_id        = var.ami_id
  instance_type = var.instance_type
  instances     = var.instances
}

module "ec2_us_west" {
  source    = "./modules/ec2"
  providers = { aws = aws.us_west }
  count     = var.deploy_us_west ? 1 : 0

  ami_id        = var.ami_id
  instance_type = var.instance_type
  instances     = var.instances
}
