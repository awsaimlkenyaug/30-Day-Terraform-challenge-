output "autoscaling_group_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.this.id
}

output "launch_template_latest_version" {
  description = "Latest version of the Launch Template"
  value       = aws_launch_template.this.latest_version
}

output "scale_up_policy_name" {
  description = "Name of the scale-up policy"
  value       = aws_autoscaling_policy.scale_up.name
}

output "scale_down_policy_name" {
  description = "Name of the scale-down policy"
  value       = aws_autoscaling_policy.scale_down.name
}
