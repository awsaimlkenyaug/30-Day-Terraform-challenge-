provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "security_group" {
  source = "./modules/security_group"
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = data.aws_ami.amazon_linux.id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
}

module "alb" {
  source            = "./modules/alb"
  security_group_id = module.security_group.security_group_id
  instance_id       = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "public_dns" {
  value = module.ec2.public_dns
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}