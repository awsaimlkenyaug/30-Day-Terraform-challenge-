# Enhanced Load Balancer Outputs
# Day 5: Scaling Infrastructure & State Management

# Load Balancer Information
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "The hosted zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "website_url" {
  description = "URL to access the website"
  value       = var.enable_https ? "https://${aws_lb.main.dns_name}" : "http://${aws_lb.main.dns_name}"
}

# Target Group Information
output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.web_servers.arn
}

output "target_group_name" {
  description = "Name of the Target Group"
  value       = aws_lb_target_group.web_servers.name
}

# Auto Scaling Group Information
output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.arn
}

output "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.min_size
}

output "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.max_size
}

output "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_servers.desired_capacity
}

# Launch Template Information
output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.web_servers.id
}

output "launch_template_latest_version" {
  description = "Latest version of the Launch Template"
  value       = aws_launch_template.web_servers.latest_version
}

# Security Groups Information
output "alb_security_group_id" {
  description = "ID of the ALB Security Group"
  value       = aws_security_group.alb.id
}

output "instances_security_group_id" {
  description = "ID of the Instances Security Group"
  value       = aws_security_group.instances.id
}

# Scaling Policies Information
output "target_tracking_policy_arn" {
  description = "ARN of the Target Tracking Scaling Policy"
  value       = aws_autoscaling_policy.target_tracking.arn
}

output "scale_up_policy_arn" {
  description = "ARN of the Scale Up Policy"
  value       = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  description = "ARN of the Scale Down Policy"
  value       = aws_autoscaling_policy.scale_down.arn
}

# CloudWatch Alarms Information
output "high_cpu_alarm_name" {
  description = "Name of the High CPU CloudWatch Alarm"
  value       = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "low_cpu_alarm_name" {
  description = "Name of the Low CPU CloudWatch Alarm"
  value       = aws_cloudwatch_metric_alarm.low_cpu.alarm_name
}

output "unhealthy_hosts_alarm_name" {
  description = "Name of the Unhealthy Hosts CloudWatch Alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name
}

# Health Check Configuration
output "health_check_configuration" {
  description = "Health check configuration details"
  value = {
    path                = aws_lb_target_group.web_servers.health_check[0].path
    healthy_threshold   = aws_lb_target_group.web_servers.health_check[0].healthy_threshold
    unhealthy_threshold = aws_lb_target_group.web_servers.health_check[0].unhealthy_threshold
    timeout             = aws_lb_target_group.web_servers.health_check[0].timeout
    interval            = aws_lb_target_group.web_servers.health_check[0].interval
    matcher             = aws_lb_target_group.web_servers.health_check[0].matcher
  }
}

# Scaling Configuration Summary
output "scaling_configuration" {
  description = "Summary of scaling configuration"
  value = {
    min_size           = var.min_size
    max_size           = var.max_size
    desired_capacity   = var.desired_capacity
    cpu_target         = var.cpu_target_percentage
    high_cpu_threshold = var.high_cpu_threshold
    low_cpu_threshold  = var.low_cpu_threshold
    scale_out_cooldown = var.scale_out_cooldown
    scale_in_cooldown  = var.scale_in_cooldown
  }
}

# Infrastructure Summary
output "infrastructure_summary" {
  description = "Complete infrastructure summary"
  value = {
    cluster_name       = local.cluster_name
    environment        = var.environment
    region             = var.aws_region
    instance_type      = var.instance_type
    server_port        = var.server_port
    availability_zones = data.aws_availability_zones.available.names
    vpc_id             = data.aws_vpc.default.id
    subnet_ids         = data.aws_subnets.default.ids
    https_enabled      = var.enable_https
    monitoring_enabled = var.enable_detailed_monitoring
    encryption_enabled = var.enable_ebs_encryption
  }
}

# Connection Information
output "connection_information" {
  description = "Information for connecting to the infrastructure"
  value = {
    load_balancer_url = var.enable_https ? "https://${aws_lb.main.dns_name}" : "http://${aws_lb.main.dns_name}"
    monitoring_links = {
      asg_cloudwatch      = "https://console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#alarmsV2:alarm/${aws_cloudwatch_metric_alarm.high_cpu.alarm_name}"
      alb_monitoring      = "https://console.aws.amazon.com/ec2/v2/home?region=${var.aws_region}#LoadBalancers:search=${aws_lb.main.name}"
      target_group_health = "https://console.aws.amazon.com/ec2/v2/home?region=${var.aws_region}#TargetGroups:search=${aws_lb_target_group.web_servers.name}"
    }
    ssh_access_note = var.enable_ssh ? "SSH access enabled for instances" : "SSH access disabled for instances"
  }
}

# Terraform State Information
output "terraform_state_info" {
  description = "Information about the Terraform state"
  value = {
    terraform_version    = ">=1.0"
    aws_provider_version = "~>5.0"
    total_resources      = "Approximately 15+ resources created"
    state_backend        = "Local state (consider using remote backend for production)"
    deployment_timestamp = timestamp()
  }
}
