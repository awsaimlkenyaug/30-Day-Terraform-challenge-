output "web_security_group_id" {
  description = "ID of the web security group"
  value       = aws_security_group.web.id
}

output "web_security_group_name" {
  description = "Name of the web security group"
  value       = aws_security_group.web.name
}

output "database_security_group_id" {
  description = "ID of the database security group"
  value       = var.create_database_sg ? aws_security_group.database[0].id : null
}

output "database_security_group_name" {
  description = "Name of the database security group"
  value       = var.create_database_sg ? aws_security_group.database[0].name : null
}
