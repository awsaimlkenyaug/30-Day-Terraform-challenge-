output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = local.deploy_alb ? module.alb[0].alb_dns_name : "ALB not deployed in this environment"
}

output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "asg_details" {
  description = "Auto Scaling Group details"
  value = {
    asg_name          = module.asg.asg_name
    asg_arn           = module.asg.asg_arn
    launch_template   = module.asg.launch_template_name
  }
}

output "security_group_id" {
  description = "Security Group ID"
  value       = module.security_group.security_group_id
}

output "module_versions" {
  description = "Module versions used in this deployment"
  value = {
    alb            = "2.0.0"
    asg            = "2.0.0"
    security_group = "2.0.0"
  }
}