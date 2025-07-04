terraform {
  backend "s3" {
    bucket         = "ngumo-terraform-state"
    key            = "day27/multi-region.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ngumo-terraform-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "us_east"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

module "vpc_east" {
  source = "./modules/vpc"
  providers = {
    aws = aws.us_east
  }

  cidr_block = "10.0.0.0/16"
  name       = "vpc-east"
  azs        = ["us-east-2a", "us-east-2b"]
}

module "vpc_west" {
  source = "./modules/vpc"
  providers = {
    aws = aws.us_west
  }

  cidr_block = "10.1.0.0/16"
  name       = "vpc-west"
  azs        = ["us-west-2a", "us-west-2b"]
}

module "ec2_app" {
  source = "./modules/ec2"
  providers = {
    aws.us_east = aws.us_east
  }

  vpc_id         = module.vpc_east.vpc_id
  public_subnets = module.vpc_east.public_subnets

  depends_on = [module.vpc_east]
}

module "alb" {
  source = "./modules/alb"
  providers = {
    aws.us_east = aws.us_east
  }

  vpc_id             = module.vpc_east.vpc_id
  public_subnets     = module.vpc_east.public_subnets
  launch_template_id = module.ec2_app.launch_template_id

  depends_on = [module.vpc_east, module.ec2_app]
}

# RDS Module
module "rds" {
  source = "./rds"
  providers = {
    aws.us_east = aws.us_east
    aws.us_west = aws.us_west
  }

  vpc_east_id           = module.vpc_east.vpc_id
  vpc_west_id           = module.vpc_west.vpc_id
  private_subnets_east  = module.vpc_east.private_subnets
  private_subnets_west  = module.vpc_west.private_subnets

  depends_on = [module.vpc_east, module.vpc_west]
}

# Route53 Module
module "route53" {
  source = "./route53"
  providers = {
    aws = aws.us_east
  }

  domain_name   = "myapp.testdomain.local"
  alb_dns_name  = module.alb.alb_dns_name
  alb_zone_id   = module.alb.alb_zone_id

  depends_on = [module.alb]
}
