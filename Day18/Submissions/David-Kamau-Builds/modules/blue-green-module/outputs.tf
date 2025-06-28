output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = "test-mode-alb-dns-name"
}

output "blue_target_group_arn" {
  description = "ARN of the blue target group"
  value       = "test-mode-blue-tg-arn"
}

output "green_target_group_arn" {
  description = "ARN of the green target group"
  value       = "test-mode-green-tg-arn"
}

output "blue_asg_name" {
  description = "Name of the blue Auto Scaling Group"
  value       = "test-mode-blue-asg"
}

output "green_asg_name" {
  description = "Name of the green Auto Scaling Group"
  value       = "test-mode-green-asg"
}

output "active_deployment" {
  description = "Currently active deployment (blue or green)"
  value       = "blue"
}

output "active_asg_name" {
  description = "Name of the currently active Auto Scaling Group"
  value       = "test-mode-active-asg"
}

output "active_version" {
  description = "Version of the currently active deployment"
  value       = "0.0.0"
}