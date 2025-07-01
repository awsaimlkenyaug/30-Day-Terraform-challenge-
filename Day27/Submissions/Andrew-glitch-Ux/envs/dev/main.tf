terraform {
  backend "s3" {
    bucket         = "bucketandrewmeistherein"
    key            = "envs/dev/terraform.tfstate"
    region         = "eu-north-1"
    use_lockfile   = true  
    encrypt        = true
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"  # Use latest 5.x version known to support Windows
    }
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

  private_subnet_ids  = module.vpc.private_subnet_ids       # ✅ Use the output for private subnet list
  target_group_arns   = [module.elb.target_group_arn]       # ✅ Output from ALB module
  common_tags         = var.common_tags
}


module "ec2" {
  source = "../../modules/ec2"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id         = module.vpc.public_subnet_id_1        
  security_group_id = module.security_group.security_group_id       
  instance_name        = var.instance_name
  common_tags          = var.common_tags
}


module "elb" {
  source = "../../modules/elb"

  alb_name            = var.alb_name
security_group_id = module.security_group.security_group_id                   # ✅ Defined in env or separate module
  subnet_ids = module.vpc.public_subnet_ids              # ✅ From VPC module output (list)
  vpc_id              = module.vpc.vpc_id                         # ✅ From VPC module output
  target_group_name   = var.target_group_name
  target_group_port   = var.target_group_port
  common_tags         = var.common_tags
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  igw_name           = var.igw_name

  public_subnet_cidr_1 = var.public_subnet_cidr_1
  public_subnet_name_1 = var.public_subnet_name_1
  public_subnet_cidr_2 = var.public_subnet_cidr_2
  public_subnet_name_2 = var.public_subnet_name_2

  private_subnet_cidr_1 = var.private_subnet_cidr_1      # ✅ ADD
  private_subnet_name_1 = var.private_subnet_name_1      # ✅ ADD
  private_subnet_cidr_2 = var.private_subnet_cidr_2      # ✅ ADD
  private_subnet_name_2 = var.private_subnet_name_2      # ✅ ADD

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2

  route_table_name            = var.route_table_name
  private_route_table_name    = var.private_route_table_name   # ✅ ADD

  nat_eip_name        = var.nat_eip_name      # ✅ ADD
  nat_gateway_name    = var.nat_gateway_name  # ✅ ADD

  common_tags = var.common_tags
}



module "security_group" {
  source = "../../modules/security_group"

  security_group_name        = var.security_group_name
  security_group_description = var.security_group_description
  vpc_id                     = module.vpc.vpc_id

  sg_ingress_description     = var.sg_ingress_description
  sg_ingress_from_port       = var.sg_ingress_from_port
  sg_ingress_to_port         = var.sg_ingress_to_port
  sg_ingress_protocol        = var.sg_ingress_protocol
  sg_ingress_cidr_blocks     = var.sg_ingress_cidr_blocks

  common_tags = var.common_tags
}


module "rds" {
  source = "../../modules/rds"  # ✅ Adjust path if necessary

  db_subnet_group_name     = var.db_subnet_group_name
  private_subnet_ids       = module.vpc.private_subnet_ids  # ✅ From VPC module
  db_identifier            = var.db_identifier
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  db_name                  = var.db_name
  username                 = var.db_username
  password                 = var.db_password
  multi_az                 = var.multi_az
  backup_retention_period  = var.backup_retention_period
  security_group_id        = module.security_group.security_group_id  # ✅ From SG module output

  common_tags              = var.common_tags
}

module "route53" {
  source = "../../modules/route53"

  # 🔄 Pass in all values via variables (clean, reusable, and env-ready)
  zone_name         = var.zone_name
  ttl               = var.ttl
  common_tags       = var.common_tags
  record_name_alb   = var.record_name_alb
  record_type_alb   = var.record_type_alb
  record_value_alb  = module.elb.alb_dns_name

  record_name_ec2   = var.record_name_ec2
  record_type_ec2   = var.record_type_ec2
  record_value_ec2  = module.ec2.public_ip

}


module "s3_replication" {
  source = "../../modules/s3_replication"

  source_bucket_name      = var.source_bucket_name
  destination_bucket_name = var.destination_bucket_name

  replication_role_name     = var.replication_role_name
  replication_rule_id       = var.replication_rule_id
  replication_storage_class = var.replication_storage_class

  common_tags = var.common_tags
}
