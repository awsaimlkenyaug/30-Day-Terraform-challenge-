output "instance_public_ip" {
  value       = length(aws_instance.web) > 0 ? aws_instance.web[0].public_ip : null
  description = "Public IP of the EC2 instance (if deployed)"
}
