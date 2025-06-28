# VPC Module for us-east-1 region
module "vpc_east" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/vpc-module"

  name_prefix         = "dkb-east"
  environment         = var.environment
  region              = "us-east-1"
  cidr_block          = "10.42.0.0/16"
  availability_zones  = ["us-east-1a", "us-east-1c"]
  allowed_cidr_blocks = var.allowed_cidr_blocks
  alb_arn             = var.alb_arn_east
  waf_web_acl_arn     = var.waf_web_acl_arn_east

  providers = {
    aws = aws.east
  }
}

# VPC Module for us-west-2 region
module "vpc_west" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/vpc-module"

  name_prefix         = "dkb-west"
  environment         = var.environment
  region              = "us-west-2"
  cidr_block          = "10.87.0.0/16"
  availability_zones  = ["us-west-2a", "us-west-2b"]
  allowed_cidr_blocks = var.allowed_cidr_blocks
  alb_arn             = var.alb_arn_west
  waf_web_acl_arn     = var.waf_web_acl_arn_west

  providers = {
    aws = aws.west
  }
}

# RDS Module for us-east-1 region
module "rds_east" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/rds-module"

  name_prefix             = "dkb-east"
  environment             = var.environment
  region                  = "us-east-1"
  username                = var.db_username
  password                = var.db_password
  vpc_id                  = var.deployment_mode == "deploy" ? module.vpc_east[0].vpc_id : "test-mode-vpc-id"
  subnet_ids              = var.deployment_mode == "deploy" ? module.vpc_east[0].public_subnet_ids : ["test-mode-subnet-id"]
  allowed_security_groups = var.deployment_mode == "deploy" ? [module.vpc_east[0].web_security_group_id] : ["test-mode-sg-id"]

  providers = {
    aws = aws.east
  }
}

# RDS Module for us-west-2 region
module "rds_west" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/rds-module"

  name_prefix             = "dkb-west"
  environment             = var.environment
  region                  = "us-west-2"
  username                = var.db_username
  password                = var.db_password
  vpc_id                  = var.deployment_mode == "deploy" ? module.vpc_west[0].vpc_id : "test-mode-vpc-id"
  subnet_ids              = var.deployment_mode == "deploy" ? module.vpc_west[0].public_subnet_ids : ["test-mode-subnet-id"]
  allowed_security_groups = var.deployment_mode == "deploy" ? [module.vpc_west[0].web_security_group_id] : ["test-mode-sg-id"]

  providers = {
    aws = aws.west
  }
}

# Blue-Green deployment module for us-east-1 region
module "east_deployment" {
  count              = var.deployment_mode == "deploy" ? 1 : 0
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-east"
  environment        = var.environment
  vpc_id             = var.deployment_mode == "deploy" ? module.vpc_east[0].vpc_id : "test-mode-vpc-id"
  subnet_ids         = var.deployment_mode == "deploy" ? module.vpc_east[0].public_subnet_ids : ["test-mode-subnet-id"]
  security_group_ids = var.deployment_mode == "deploy" ? [module.vpc_east[0].web_security_group_id] : ["test-mode-sg-id"]
  ssh_key_name       = "dkb-east-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"

  instance_profile_name = var.deployment_mode == "deploy" ? module.east_secrets[0].instance_profile_name : "test-mode-instance-profile"
  secret_name           = var.deployment_mode == "deploy" ? module.east_secrets[0].secret_name : "test-mode-secret-name"
  region                = "us-east-1"

  providers = {
    aws = aws.east
  }
}

# Blue-Green deployment module for us-west-2 region
module "west_deployment" {
  count              = var.deployment_mode == "deploy" ? 1 : 0
  source             = "../modules/blue-green-module"
  name_prefix        = "dkb-west"
  environment        = var.environment
  vpc_id             = var.deployment_mode == "deploy" ? module.vpc_west[0].vpc_id : "test-mode-vpc-id"
  subnet_ids         = var.deployment_mode == "deploy" ? module.vpc_west[0].public_subnet_ids : ["test-mode-subnet-id"]
  security_group_ids = var.deployment_mode == "deploy" ? [module.vpc_west[0].web_security_group_id] : ["test-mode-sg-id"]
  ssh_key_name       = "dkb-west-key"
  instance_count     = var.instance_count
  active_deployment  = var.active_deployment
  blue_version       = "2.1.0"
  green_version      = "2.2.0"

  instance_profile_name = var.deployment_mode == "deploy" ? module.west_secrets[0].instance_profile_name : "test-mode-instance-profile"
  secret_name           = var.deployment_mode == "deploy" ? module.west_secrets[0].secret_name : "test-mode-secret-name"
  region                = "us-west-2"

  providers = {
    aws = aws.west
  }
}

# EKS Cluster in us-east-1 region
module "eks_cluster_east" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/eks-module"

  name_prefix         = "dkb-east"
  environment         = var.environment
  vpc_id              = var.deployment_mode == "deploy" ? module.vpc_east[0].vpc_id : "test-mode-vpc-id"
  subnet_ids          = var.deployment_mode == "deploy" ? module.vpc_east[0].public_subnet_ids : ["test-mode-subnet-id"]
  allowed_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  providers = {
    aws = aws.east
  }
}

# GCP Infrastructure Module
module "gcp_infrastructure" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
  source = "../modules/gcp-module"

  name_prefix              = var.name_prefix
  environment              = var.environment
  region                   = var.gcp_region
  node_count               = var.gcp_node_count
  authorized_networks_cidr = "10.0.0.0/8"
  domain                   = "example.com"
}

# Outputs
output "east_vpc_id" {
  description = "ID of the VPC in us-east-1 region"
  value       = var.deployment_mode == "deploy" ? module.vpc_east[0].vpc_id : "test-mode-no-vpc"
}

output "west_vpc_id" {
  description = "ID of the VPC in us-west-2 region"
  value       = var.deployment_mode == "deploy" ? module.vpc_west[0].vpc_id : "test-mode-no-vpc"
}

output "east_db_endpoint" {
  description = "Database endpoint in us-east-1 region"
  value       = var.deployment_mode == "deploy" ? module.rds_east[0].db_instance_endpoint : "test-mode-no-db"
}

output "west_db_endpoint" {
  description = "Database endpoint in us-west-2 region"
  value       = var.deployment_mode == "deploy" ? module.rds_west[0].db_instance_endpoint : "test-mode-no-db"
}

output "east_alb_dns_name" {
  description = "DNS name of the load balancer in us-east-1 region"
  value       = var.deployment_mode == "deploy" ? module.east_deployment[0].alb_dns_name : "test-mode-no-alb"
}

output "west_alb_dns_name" {
  description = "DNS name of the load balancer in us-west-2 region"
  value       = var.deployment_mode == "deploy" ? module.west_deployment[0].alb_dns_name : "test-mode-no-alb"
}

output "east_active_deployment" {
  description = "Currently active deployment in us-east-1 region (blue or green)"
  value       = var.deployment_mode == "deploy" ? module.east_deployment[0].active_deployment : "test-mode"
}

output "west_active_deployment" {
  description = "Currently active deployment in us-west-2 region (blue or green)"
  value       = var.deployment_mode == "deploy" ? module.west_deployment[0].active_deployment : "test-mode"
}

output "east_active_version" {
  description = "Version of the currently active deployment in us-east-1 region"
  value       = var.deployment_mode == "deploy" ? module.east_deployment[0].active_version : "0.0.0"
}

output "west_active_version" {
  description = "Version of the currently active deployment in us-west-2 region"
  value       = var.deployment_mode == "deploy" ? module.west_deployment[0].active_version : "0.0.0"
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = var.deployment_mode == "deploy" ? module.eks_cluster_east[0].cluster_name : "test-mode-no-cluster"
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = var.deployment_mode == "deploy" ? module.eks_cluster_east[0].cluster_endpoint : "test-mode-no-endpoint"
}

output "gcp_network_name" {
  description = "The name of the GCP VPC network"
  value       = var.deployment_mode == "deploy" ? module.gcp_infrastructure[0].network_name : "test-mode-no-network"
}

output "gcp_subnet_name" {
  description = "The name of the GCP subnet"
  value       = var.deployment_mode == "deploy" ? module.gcp_infrastructure[0].subnet_name : "test-mode-no-subnet"
}

output "gcp_cluster_name" {
  description = "The name of the GKE cluster"
  value       = var.deployment_mode == "deploy" ? module.gcp_infrastructure[0].cluster_name : "test-mode-no-cluster"
}

output "gcp_cluster_endpoint" {
  description = "The endpoint for the GKE cluster"
  value       = var.deployment_mode == "deploy" ? module.gcp_infrastructure[0].cluster_endpoint : "test-mode-no-endpoint"
}