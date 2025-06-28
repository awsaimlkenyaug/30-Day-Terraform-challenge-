output "instance_ids" {
  description = "Map of instance names to their IDs"
  value       = { for k, v in aws_instance.this : k => v.id }
}

output "public_ips" {
  description = "Map of instance names to their public IPs"
  value       = { for k, v in aws_instance.this : k => v.public_ip }
}

output "public_dns" {
  description = "Map of instance names to their public DNS"
  value       = { for k, v in aws_instance.this : k => v.public_dns }
}

# For backward compatibility
output "instance_id" {
  description = "The EC2 instance ID of the main instance"
  value       = contains(keys(aws_instance.this), "main") ? aws_instance.this["main"].id : null
}

output "public_ip" {
  description = "The EC2 instance public IP of the main instance"
  value       = contains(keys(aws_instance.this), "main") ? aws_instance.this["main"].public_ip : null
}