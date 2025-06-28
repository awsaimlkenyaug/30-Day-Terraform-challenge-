output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

# For compatibility with previous versions
output "instance_id" {
  description = "The EC2 instance ID (not applicable for ASG)"
  value       = "See asg_name for the Auto Scaling Group name"
}

output "public_ip" {
  description = "The EC2 instance public IP (not directly available for ASG)"
  value       = "Use AWS CLI or Console to get IPs of instances in the ASG"
}