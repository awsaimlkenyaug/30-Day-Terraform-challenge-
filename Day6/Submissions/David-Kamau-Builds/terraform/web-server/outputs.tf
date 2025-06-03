output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.web_asg.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.web_lt.id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "security_group_id" {
  description = "Security Group ID used by web servers"
  value       = aws_security_group.web_sg.id
}

output "current_asg_instances" {
  description = "List of instance IDs currently running in the ASG"
  value       = aws_autoscaling_group.web_asg.instances[*].id
}
