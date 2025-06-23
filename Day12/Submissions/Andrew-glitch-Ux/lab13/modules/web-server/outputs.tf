output "instance_id" {
  value       = aws_instance.web.id
  description = "Web server instance ID"
}
output "public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the web server"
}
