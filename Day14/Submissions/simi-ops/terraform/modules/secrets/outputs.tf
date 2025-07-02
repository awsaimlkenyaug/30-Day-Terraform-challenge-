output "secret_arn" {
  description = "ARN of the secrets manager secret"
  value       = aws_secretsmanager_secret.app_secrets.arn
}

output "secret_name" {
  description = "Name of the secrets manager secret"
  value       = aws_secretsmanager_secret.app_secrets.name
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile for secrets access"
  value       = aws_iam_instance_profile.secrets_access.name
}

output "iam_role_arn" {
  description = "ARN of the IAM role for secrets access"
  value       = aws_iam_role.secrets_access.arn
  sensitive   = true
}