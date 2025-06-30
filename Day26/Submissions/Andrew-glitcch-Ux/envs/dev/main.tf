terraform {
  backend "s3" {
    bucket         = "bucketandrewmeisthere"
    key            = "envs/dev/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true  
    encrypt        = true
  }
}


provider "aws" {
  region = var.aws_region
}



module "asg" {
  source = "../../modules/asg"

  launch_template_name = var.launch_template_name
  ami_id               = var.ami_id
  instance_type        = var.instance_type

  asg_name         = var.asg_name
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  subnet_id = module.vpc.public_subnet_id_1       # ✅ Output from VPC module
  target_group_arns = [module.elb.target_group_arn]      # ✅ Output from ALB module
  common_tags       = var.common_tags
}


module "ec2" {
  source = "../../modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id         = module.vpc.public_subnet_id_1        
  security_group_id    = aws_security_group.this.id               # ✅ Could be defined in envs or separate module
  instance_name        = var.instance_name
  common_tags          = var.common_tags
}


module "elb" {
  source = "../../modules/elb"

  alb_name            = var.alb_name
  security_group_id   = aws_security_group.this.id                    # ✅ Defined in env or separate module
  subnet_ids = module.vpc.public_subnet_ids              # ✅ From VPC module output (list)
  vpc_id              = module.vpc.vpc_id                         # ✅ From VPC module output
  target_group_name   = var.target_group_name
  target_group_port   = var.target_group_port
  common_tags         = var.common_tags
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  igw_name             = var.igw_name
  public_subnet_cidr_1   = var.public_subnet_cidr_1
  public_subnet_name_1   = var.public_subnet_name_1
  availability_zone_1   = var.availability_zone_1
  public_subnet_cidr_2 = var.public_subnet_cidr_2
  public_subnet_name_2 = var.public_subnet_name_2      # ← Add this line
  availability_zone_2  = var.availability_zone_2
  route_table_name     = var.route_table_name
  common_tags          = var.common_tags
}



resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id  # 💬 from VPC module output

  ingress {
    description = var.sg_ingress_description
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.security_group_name
    }
  )
}

