# Production Environment Outputs

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

# Security Group Outputs
output "web_security_group_id" {
  description = "ID of the web security group"
  value       = module.security_groups.web_security_group_id
}

output "database_security_group_id" {
  description = "ID of the database security group"
  value       = module.security_groups.database_security_group_id
}

# Compute Outputs
output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = module.compute.autoscaling_group_arn
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.compute.autoscaling_group_name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = module.compute.launch_template_id
}

output "scale_up_policy_arn" {
  description = "ARN of scale up policy"
  value       = module.compute.scale_up_policy_arn
}

output "scale_down_policy_arn" {
  description = "ARN of scale down policy"
  value       = module.compute.scale_down_policy_arn
}

# Load Balancer Outputs
output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.load_balancer.load_balancer_arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.load_balancer.load_balancer_dns_name
}

output "load_balancer_zone_id" {
  description = "Hosted zone ID of the Application Load Balancer"
  value       = module.load_balancer.load_balancer_zone_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.load_balancer.target_group_arn
}

# Application URL
output "application_url" {
  description = "URL of the deployed application"
  value       = "http://${module.load_balancer.load_balancer_dns_name}"
}
