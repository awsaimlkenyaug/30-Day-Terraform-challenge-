output "instance_id" {
  description = "The EC2 instance ID"
  value       = length(aws_instance.this) > 0 ? aws_instance.this[0].id : null
}

output "public_ip" {
  description = "The EC2 instance public IP"
  value       = length(aws_instance.this) > 0 ? aws_instance.this[0].public_ip : null
}

output "public_dns" {
  description = "The EC2 instance public DNS"
  value       = length(aws_instance.this) > 0 ? aws_instance.this[0].public_dns : null
}