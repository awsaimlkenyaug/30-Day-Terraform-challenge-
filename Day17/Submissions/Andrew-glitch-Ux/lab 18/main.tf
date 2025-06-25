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
  region = var.aws_region
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_a_id   = module.public_subnet_a.subnet_id
  public_subnet_b_id   = module.public_subnet_b.subnet_id
}


module "public_subnet_a" {
  source                  = "../../modules/subnet"
  name                    = var.public_subnet_a_name
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.public_subnet_a_az
  map_public_ip_on_launch = true
}

module "public_subnet_b" {
  source                  = "../../modules/subnet"
  name                    = var.public_subnet_b_name
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.public_subnet_b_az
  map_public_ip_on_launch = true
}
# Private Subnet
module "private_subnet" {
  source     = "../../modules/private-subnet"
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.private_subnet_cidr
  az         = var.private_az
  name       = var.private_subnet_name
}


module "alb" {
  source              = "../../modules/alb"
  name                = var.alb_name
  subnet_ids          = [module.public_subnet_a.subnet_id, module.public_subnet_b.subnet_id] 
  security_group_ids  = [aws_security_group.alb_sg.id] 
  vpc_id              = module.vpc.vpc_id
}

# ASG Rolling Deploy
module "asg" {
  source                = "../../modules/asg-rolling-deploy"
  name                  = var.asg_name
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  subnet_ids            = [module.private_subnet.subnet_id]
  security_group_ids    = [aws_security_group.asg_sg.id]
  key_name              = var.key_name
  desired_capacity      = var.desired_capacity
  min_size              = var.min_size
  max_size              = var.max_size
  tags                  = var.asg_tags
  alb_target_group_arn  = module.alb.target_group_arn
}

# Bastion Host
module "bastion" {
  source              = "../../modules/bastion-host"
  ami_id              = var.ami_id
  instance_type       = var.bastion_instance_type
  subnet_id           = module.public_subnet_a.subnet_id
  key_name            = var.key_name
  security_group_ids  = [aws_security_group.bastion_sg.id]
  name                = var.bastion_name
  public_key = file(var.public_key_path)

}

# Dummy security groups (if not in module)
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "ALB security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "asg_sg" {
  name        = "asg-sg"
  description = "ASG security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Bastion host security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
