output "secret_arn" {
  description = "ARN of the secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.app_secrets.arn
}

output "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.app_secrets.name
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile for accessing secrets"
  value       = aws_iam_instance_profile.secrets_instance_profile.name
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile for accessing secrets"
  value       = aws_iam_instance_profile.secrets_instance_profile.arn
}