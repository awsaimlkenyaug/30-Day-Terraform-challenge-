output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.this.dns_name
}

output "blue_target_group_arn" {
  description = "ARN of the blue target group"
  value       = aws_lb_target_group.blue.arn
}

output "green_target_group_arn" {
  description = "ARN of the green target group"
  value       = aws_lb_target_group.green.arn
}

output "blue_asg_name" {
  description = "Name of the blue Auto Scaling Group"
  value       = aws_autoscaling_group.blue.name
}

output "green_asg_name" {
  description = "Name of the green Auto Scaling Group"
  value       = aws_autoscaling_group.green.name
}

output "active_deployment" {
  description = "Currently active deployment (blue or green)"
  value       = var.active_deployment
}

output "active_asg_name" {
  description = "Name of the currently active Auto Scaling Group"
  value       = var.active_deployment == "blue" ? aws_autoscaling_group.blue.name : aws_autoscaling_group.green.name
}

output "active_version" {
  description = "Version of the currently active deployment"
  value       = var.active_deployment == "blue" ? var.blue_version : var.green_version
}