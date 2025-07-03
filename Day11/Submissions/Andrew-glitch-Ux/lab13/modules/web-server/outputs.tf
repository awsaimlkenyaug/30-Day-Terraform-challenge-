output "instance_id" {
  value       = try(aws_instance.web[0].id, null)
  description = "ID of the deployed EC2 instance"
}

output "public_ip" {
  value       = try(aws_instance.web[0].public_ip, null)
  description = "Public IP of the deployed instance"
}
