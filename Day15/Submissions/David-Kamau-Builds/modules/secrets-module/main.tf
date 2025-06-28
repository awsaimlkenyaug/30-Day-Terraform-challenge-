terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_secretsmanager_secret" "app_secrets" {
  name                    = "${var.name_prefix}-${var.environment}-secrets"
  description             = "Secrets for ${var.name_prefix} application in ${var.environment} environment"
  recovery_window_in_days = var.recovery_window_in_days

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-secrets"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_secretsmanager_secret_version" "app_secrets_version" {
  secret_id     = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode(var.secret_values)
}

resource "aws_iam_role" "secrets_access_role" {
  name = "${var.name_prefix}-${var.environment}-secrets-access-role"
  
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

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-secrets-access-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_policy" "secrets_access_policy" {
  name        = "${var.name_prefix}-${var.environment}-secrets-access-policy"
  description = "Policy for accessing ${var.name_prefix} secrets in ${var.environment} environment"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect   = "Allow"
        Resource = aws_secretsmanager_secret.app_secrets.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_policy_attachment" {
  role       = aws_iam_role.secrets_access_role.name
  policy_arn = aws_iam_policy.secrets_access_policy.arn
}

resource "aws_iam_instance_profile" "secrets_instance_profile" {
  name = "${var.name_prefix}-${var.environment}-secrets-profile"
  role = aws_iam_role.secrets_access_role.name
}