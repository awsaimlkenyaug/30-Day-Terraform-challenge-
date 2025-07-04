output "web_instance_ids" {
  value       = aws_instance.web_server[*].id
  description = "Web server instance IDs (if created)"
}
