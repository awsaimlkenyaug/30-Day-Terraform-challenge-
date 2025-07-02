terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  module_version = "1.0.0"
  secret_name    = "${var.name_prefix}-secrets"
}

# Create AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "app_secrets" {
  name                    = local.secret_name
  description             = "Application secrets for ${var.environment} environment"
  recovery_window_in_days = var.environment == "production" ? 30 : 0

  tags = merge(var.tags, {
    Name          = local.secret_name
    Module        = "secrets"
    ModuleVersion = local.module_version
  })
}

# Store secret values
resource "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    database_password = var.database_password
    api_key          = var.api_key
    jwt_secret       = var.jwt_secret
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# Create IAM role for EC2 instances to access secrets
resource "aws_iam_role" "secrets_access" {
  name = "${var.name_prefix}-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# IAM policy for secrets access
resource "aws_iam_role_policy" "secrets_access" {
  name = "${var.name_prefix}-secrets-policy"
  role = aws_iam_role.secrets_access.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.app_secrets.arn
      }
    ]
  })
}

# Instance profile for EC2
resource "aws_iam_instance_profile" "secrets_access" {
  name = "${var.name_prefix}-secrets-profile"
  role = aws_iam_role.secrets_access.name

  tags = var.tags
}