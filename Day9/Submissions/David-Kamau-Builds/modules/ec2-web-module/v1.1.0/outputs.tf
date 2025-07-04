output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "The EC2 instance public IP"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "The EC2 instance public DNS"
  value       = aws_instance.this.public_dns
}