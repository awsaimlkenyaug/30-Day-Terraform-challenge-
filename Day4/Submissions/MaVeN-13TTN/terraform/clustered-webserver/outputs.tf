# Output values for Clustered Web Server

# Load Balancer Information
output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "load_balancer_url" {
  description = "URL to access the load balancer"
  value       = "http://${aws_lb.main.dns_name}"
}

output "load_balancer_https_url" {
  description = "HTTPS URL to access the load balancer (if HTTPS is enabled)"
  value       = var.enable_https ? "https://${aws_lb.main.dns_name}" : "HTTPS not enabled"
}

# Auto Scaling Group Information
output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.name
}

output "autoscaling_group_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.arn
}

output "autoscaling_group_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.min_size
}

output "autoscaling_group_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.max_size
}

output "autoscaling_group_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.desired_capacity
}

output "autoscaling_group_availability_zones" {
  description = "Availability zones used by the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.availability_zones
}

# Target Group Information
output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.web_servers.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.web_servers.name
}

# Security Group Information
output "load_balancer_security_group_id" {
  description = "Security group ID for the load balancer"
  value       = aws_security_group.alb.id
}

output "web_servers_security_group_id" {
  description = "Security group ID for the web servers"
  value       = aws_security_group.web_servers.id
}

# Launch Template Information
output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.web_servers.id
}

output "launch_template_latest_version" {
  description = "Latest version of the launch template"
  value       = aws_launch_template.web_servers.latest_version
}

# Network Information
output "vpc_id" {
  description = "VPC ID where resources are deployed"
  value       = data.aws_vpc.default.id
}

output "subnet_ids" {
  description = "Subnet IDs where resources are deployed"
  value       = data.aws_subnets.default.ids
}

output "availability_zones" {
  description = "Availability zones used for deployment"
  value       = data.aws_availability_zones.available.names
}

# AMI Information
output "ami_id" {
  description = "AMI ID used for instances"
  value       = data.aws_ami.amazon_linux.id
}

output "ami_name" {
  description = "AMI name used for instances"
  value       = data.aws_ami.amazon_linux.name
}

# Auto Scaling Policies (if enabled)
output "scale_up_policy_arn" {
  description = "ARN of the scale up policy"
  value       = var.enable_autoscaling_policies ? aws_autoscaling_policy.scale_up[0].arn : "Auto scaling policies not enabled"
}

output "scale_down_policy_arn" {
  description = "ARN of the scale down policy"
  value       = var.enable_autoscaling_policies ? aws_autoscaling_policy.scale_down[0].arn : "Auto scaling policies not enabled"
}

# CloudWatch Alarms (if enabled)
output "cpu_high_alarm_name" {
  description = "Name of the CPU high alarm"
  value       = var.enable_autoscaling_policies ? aws_cloudwatch_metric_alarm.cpu_high[0].alarm_name : "Auto scaling policies not enabled"
}

output "cpu_low_alarm_name" {
  description = "Name of the CPU low alarm"
  value       = var.enable_autoscaling_policies ? aws_cloudwatch_metric_alarm.cpu_low[0].alarm_name : "Auto scaling policies not enabled"
}

# Configuration Summary
output "configuration_summary" {
  description = "Summary of the deployed configuration"
  value = {
    environment               = var.environment
    project_name              = var.project_name
    instance_type             = var.instance_type
    min_size                  = var.min_size
    max_size                  = var.max_size
    desired_capacity          = var.desired_capacity
    server_port               = var.server_port
    health_check_type         = var.health_check_type
    load_balancer_type        = var.load_balancer_type
    autoscaling_enabled       = var.enable_autoscaling_policies
    https_enabled             = var.enable_https
    ssh_access_enabled        = var.enable_ssh_access
    detailed_monitoring       = var.enable_detailed_monitoring
    cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  }
}

# Deployment Information
output "deployment_info" {
  description = "Information about the deployment"
  value = {
    terraform_version    = "~> 1.0"
    aws_provider_version = "~> 5.0"
    region               = var.aws_region
    deployment_timestamp = timestamp()
    application_name     = var.application_name
    application_version  = var.application_version
  }
}
