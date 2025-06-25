output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.single.id
}

output "public_ip" {
  description = "Elastic IP of the EC2 instance"
  value       = aws_eip.single_eip.public_ip
}

output "public_dns" {
  description = "Public DNS name of EC2"
  value       = aws_instance.single.public_dns
}
