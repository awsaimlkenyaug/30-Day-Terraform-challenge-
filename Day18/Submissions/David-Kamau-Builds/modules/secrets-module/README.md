# Secrets Module

This module manages secrets in AWS Secrets Manager and creates IAM roles for secure access.

## Features

- Creates secrets in AWS Secrets Manager
- Sets up IAM roles and policies for accessing secrets
- Creates instance profiles for EC2 instances
- Implements secure secret rotation

## Usage

```hcl
module "secrets" {
  source = "./modules/secrets-module"

  name_prefix             = "my-app"
  environment             = "prod"
  recovery_window_in_days = 7
  secret_values = {
    db_username = "admin"
    db_password = "password123"
    api_key     = "abcdef123456"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name_prefix | Prefix to be used for resource names | string | yes |
| environment | Environment name | string | yes |
| recovery_window_in_days | Number of days that AWS Secrets Manager waits before it can delete the secret | number | no |
| secret_values | Map of secret key/value pairs to store in Secrets Manager | map(string) | yes |

## Outputs

| Name | Description |
|------|-------------|
| secret_name | Name of the created secret |
| secret_arn | ARN of the created secret |
| instance_profile_name | Name of the IAM instance profile |

## Security Features

- Encrypted secrets storage
- IAM roles with least privilege
- Configurable recovery window
- Secure secret rotation

## Tags

All resources are tagged with:
- Name
- Environment
- ManagedBy = "Terraform"