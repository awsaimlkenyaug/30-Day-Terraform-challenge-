terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "web" {
  source             = "../modules/ec2-web-module/v2.0.0"
  name_prefix        = "dkb-web"
  environment        = var.environment
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  ssh_key_name       = var.ssh_key_name
  instance_count     = var.instance_count
  enable_monitoring  = var.enable_monitoring
}

output "web_public_ip" {
  value = module.web.public_ip
}