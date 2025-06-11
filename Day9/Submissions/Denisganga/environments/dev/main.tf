provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source         = "../../modules/ec2-instance"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = var.subnet_id
  instance_name  = var.instance_name
  environment    = var.environment
}
