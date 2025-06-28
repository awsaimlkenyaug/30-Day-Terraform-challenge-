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

# Lambda function for secrets rotation (basic implementation)
resource "aws_lambda_function" "secrets_rotation" {
  count         = var.enable_rotation ? 1 : 0
  filename      = data.archive_file.rotation_lambda_zip[count.index].output_path
  function_name = "${var.name_prefix}-${var.environment}-secrets-rotation"
  role          = aws_iam_role.rotation_lambda_role[count.index].arn
  handler       = "index.handler"
  runtime       = "python3.9"
  timeout       = 30

  source_code_hash = data.archive_file.rotation_lambda_zip[count.index].output_base64sha256

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-secrets-rotation"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

data "archive_file" "rotation_lambda_zip" {
  count       = var.enable_rotation ? 1 : 0
  type        = "zip"
  output_path = "secrets_rotation.zip"
  source {
    content  = <<EOF
import json
import boto3

def handler(event, context):
    # Basic rotation logic - customize as needed
    return {
        'statusCode': 200,
        'body': json.dumps('Rotation completed')
    }
EOF
    filename = "index.py"
  }
}

resource "aws_iam_role" "rotation_lambda_role" {
  count = var.enable_rotation ? 1 : 0
  name  = "${var.name_prefix}-${var.environment}-rotation-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "rotation_lambda_policy" {
  count = var.enable_rotation ? 1 : 0
  name  = "${var.name_prefix}-${var.environment}-rotation-lambda-policy"
  role  = aws_iam_role.rotation_lambda_role[count.index].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage"
        ]
        Resource = aws_secretsmanager_secret.app_secrets.arn
      }
    ]
  })
}

resource "aws_secretsmanager_secret_rotation" "app_secrets_rotation" {
  count               = var.enable_rotation ? 1 : 0
  secret_id           = aws_secretsmanager_secret.app_secrets.id
  rotation_lambda_arn = aws_lambda_function.secrets_rotation[count.index].arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
}