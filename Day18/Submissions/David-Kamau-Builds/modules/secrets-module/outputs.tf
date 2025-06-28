output "secret_arn" {
  description = "ARN of the secret in AWS Secrets Manager"
  value       = "arn:aws:secretsmanager:us-east-1:123456789012:secret:test-mode-secret"
}

output "secret_name" {
  description = "Name of the secret in AWS Secrets Manager"
  value       = "test-mode-secret-name"
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile for accessing secrets"
  value       = "test-mode-instance-profile"
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile for accessing secrets"
  value       = "arn:aws:iam::123456789012:instance-profile/test-mode-instance-profile"
}