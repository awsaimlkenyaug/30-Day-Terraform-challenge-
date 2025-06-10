# Development Environment Outputs

output "environment" {
  description = "Environment name"
  value       = local.environment
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
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

output "web_security_group_id" {
  description = "ID of the web security group"
  value       = module.security_groups.web_security_group_id
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.load_balancer.load_balancer_dns_name
}

output "load_balancer_url" {
  description = "URL of the load balancer"
  value       = module.load_balancer.load_balancer_url
}

output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.compute.autoscaling_group_name
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = module.compute.launch_template_id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = module.load_balancer.target_group_arn
}

output "instance_configuration" {
  description = "Instance configuration details"
  value = {
    instance_type    = local.instance_type
    min_size         = local.min_size
    max_size         = local.max_size
    desired_capacity = local.desired_capacity
  }
}

output "access_information" {
  description = "Information for accessing the application"
  value = {
    load_balancer_url = module.load_balancer.load_balancer_url
    dns_name          = module.load_balancer.load_balancer_dns_name
    environment       = local.environment
    application       = var.application_name
  }
}
