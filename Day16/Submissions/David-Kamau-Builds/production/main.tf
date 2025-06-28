# VPC Module for us-east-1 region
module "vpc_east" {
  source = "../modules/vpc-module"
  
  name_prefix        = "dkb-east"
  environment        = var.environment
  region            = "us-east-1"
  cidr_block        = "10.42.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1c"]
  
  providers = {
    aws = aws.east
  }
}

# VPC Module for us-west-2 region
module "vpc_west" {
  source = "../modules/vpc-module"
  
  name_prefix        = "dkb-west"
  environment        = var.environment
  region            = "us-west-2"
  cidr_block        = "10.87.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b"]
  
  providers = {
    aws = aws.west
  }
}

# RDS Module for us-east-1 region
module "rds_east" {
  source = "../modules/rds-module"
  
  name_prefix = "dkb-east"
  environment = var.environment
  region      = "us-east-1"
  username    = var.db_username
  password    = var.db_password
  vpc_id      = module.vpc_east.vpc_id
  subnet_ids  = module.vpc_east.public_subnet_ids
  
  providers = {
    aws = aws.east
  }
}

# RDS Module for us-west-2 region
module "rds_west" {
  source = "../modules/rds-module"
  
  name_prefix = "dkb-west"
  environment = var.environment
  region      = "us-west-2"
  username    = var.db_username
  password    = var.db_password
  vpc_id      = module.vpc_west.vpc_id
  subnet_ids  = module.vpc_west.public_subnet_ids
  
  providers = {
    aws = aws.west
  }
}

# Blue-Green deployment module for us-east-1 region
module "east_deployment" {
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-east"
  environment        = var.environment
  vpc_id             = module.vpc_east.vpc_id
  subnet_ids         = module.vpc_east.public_subnet_ids
  security_group_ids = [module.vpc_east.web_security_group_id]
  ssh_key_name       = "dkb-east-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"
  
  instance_profile_name = module.east_secrets.instance_profile_name
  secret_name           = module.east_secrets.secret_name
  region                = "us-east-1"
  
  providers = {
    aws = aws.east
  }
}

# Blue-Green deployment module for us-west-2 region
module "west_deployment" {
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-west"
  environment        = var.environment
  vpc_id             = module.vpc_west.vpc_id
  subnet_ids         = module.vpc_west.public_subnet_ids
  security_group_ids = [module.vpc_west.web_security_group_id]
  ssh_key_name       = "dkb-west-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"
  
  instance_profile_name = module.west_secrets.instance_profile_name
  secret_name           = module.west_secrets.secret_name
  region                = "us-west-2"
  
  providers = {
    aws = aws.west
  }
}

# EKS Cluster in us-east-1 region
module "eks_cluster_east" {
  source = "../modules/eks-module"

  name_prefix = "dkb-east"
  environment = var.environment
  vpc_id      = module.vpc_east.vpc_id
  subnet_ids  = module.vpc_east.public_subnet_ids

  providers = {
    aws = aws.east
  }
}

# GCP Infrastructure Module
module "gcp_infrastructure" {
  source = "../modules/gcp-module"

  name_prefix = var.name_prefix
  environment = var.environment
  region      = var.gcp_region
  node_count  = var.gcp_node_count
}

# Outputs
output "east_vpc_id" {
  description = "ID of the VPC in us-east-1 region"
  value       = module.vpc_east.vpc_id
}

output "west_vpc_id" {
  description = "ID of the VPC in us-west-2 region"
  value       = module.vpc_west.vpc_id
}

output "east_db_endpoint" {
  description = "Database endpoint in us-east-1 region"
  value       = module.rds_east.db_instance_endpoint
}

output "west_db_endpoint" {
  description = "Database endpoint in us-west-2 region"
  value       = module.rds_west.db_instance_endpoint
}

output "east_alb_dns_name" {
  description = "DNS name of the load balancer in us-east-1 region"
  value       = module.east_deployment.alb_dns_name
}

output "west_alb_dns_name" {
  description = "DNS name of the load balancer in us-west-2 region"
  value       = module.west_deployment.alb_dns_name
}

output "east_active_deployment" {
  description = "Currently active deployment in us-east-1 region (blue or green)"
  value       = module.east_deployment.active_deployment
}

output "west_active_deployment" {
  description = "Currently active deployment in us-west-2 region (blue or green)"
  value       = module.west_deployment.active_deployment
}

output "east_active_version" {
  description = "Version of the currently active deployment in us-east-1 region"
  value       = module.east_deployment.active_version
}

output "west_active_version" {
  description = "Version of the currently active deployment in us-west-2 region"
  value       = module.west_deployment.active_version
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks_cluster_east.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks_cluster_east.cluster_endpoint
}

output "gcp_network_name" {
  description = "The name of the GCP VPC network"
  value       = module.gcp_infrastructure.network_name
}

output "gcp_subnet_name" {
  description = "The name of the GCP subnet"
  value       = module.gcp_infrastructure.subnet_name
}

output "gcp_cluster_name" {
  description = "The name of the GKE cluster"
  value       = module.gcp_infrastructure.cluster_name
}

output "gcp_cluster_endpoint" {
  description = "The endpoint for the GKE cluster"
  value       = module.gcp_infrastructure.cluster_endpoint
}