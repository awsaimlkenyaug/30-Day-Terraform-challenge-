output "ec2_instance_ids" {
  value       = aws_instance.conditional_ec2[*].id
  description = "IDs of created EC2 instances (if any)"
}
