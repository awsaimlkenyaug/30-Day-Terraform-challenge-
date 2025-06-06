output "workspace_name" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}

output "environment" {
  description = "Current environment"
  value       = local.environment
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.workspace_vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.workspace_vpc.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.workspace_public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.workspace_private_subnet[*].id
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.workspace_web_lb.dns_name
}

output "load_balancer_url" {
  description = "URL of the load balancer"
  value       = "http://${aws_lb.workspace_web_lb.dns_name}"
}

output "auto_scaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.workspace_web_asg.name
}

output "instance_type" {
  description = "EC2 instance type used"
  value       = local.current_config.instance_type
}

output "asg_capacity" {
  description = "Auto Scaling Group capacity settings"
  value = {
    min_size     = local.current_config.min_size
    max_size     = local.current_config.max_size
    desired_size = local.current_config.desired_size
  }
}
