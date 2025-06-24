output "db_instance_endpoint" {
  value       = module.db.db_endpoint
  description = "The endpoint of the deployed RDS instance"
  sensitive   = true
}
