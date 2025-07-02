output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "List of public IPs of the EC2 instances"
  value       = aws_instance.web[*].public_ip
}

output "public_dns" {
  description = "List of public DNS names of the EC2 instances"
  value       = aws_instance.web[*].public_dns
}

output "private_ips" {
  description = "List of private IPs of the EC2 instances"
  value       = aws_instance.web[*].private_ip
}