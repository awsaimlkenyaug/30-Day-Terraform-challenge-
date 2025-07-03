output "primary_endpoint" {
  description = "RDS primary instance endpoint"
  value       = aws_db_instance.primary.endpoint
}

output "primary_port" {
  description = "RDS primary instance port"
  value       = aws_db_instance.primary.port
}

output "replica_endpoint" {
  description = "RDS replica instance endpoint"
  value       = aws_db_instance.replica.endpoint
}

output "replica_port" {
  description = "RDS replica instance port"
  value       = aws_db_instance.replica.port
}

output "primary_db_name" {
  description = "Database name"
  value       = aws_db_instance.primary.db_name
}