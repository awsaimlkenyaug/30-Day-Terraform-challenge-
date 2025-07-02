# Security Best Practices

## Secrets Management

This infrastructure implements secure secrets management using AWS Secrets Manager with the following security measures:

### 1. AWS Secrets Manager Integration
- Secrets are stored encrypted in AWS Secrets Manager
- Automatic encryption at rest using AWS KMS
- Secrets are retrieved at runtime, not stored in code

### 2. IAM Role-Based Access
- EC2 instances use IAM roles to access secrets
- Principle of least privilege applied
- No hardcoded credentials in code or configuration

### 3. Terraform State Security
- Sensitive variables marked with `sensitive = true`
- Secrets masked in Terraform plan/apply output
- State file encryption enabled in S3 backend

### 4. Runtime Security
- Secrets retrieved dynamically during instance startup
- Configuration files secured with proper permissions (600)
- Secrets not logged or exposed in user data

### 5. Environment Separation
- Different secrets per environment
- Separate IAM roles and policies per environment
- Environment-specific secret recovery policies

## Usage Guidelines

### For Development
```bash
# Use separate secrets file
terraform apply -var-file="environments/dev/terraform.tfvars" -var-file="environments/dev/secrets.tfvars"
```

### For Production
```bash
# Use environment variables instead of files
export TF_VAR_database_password="$PROD_DB_PASSWORD"
export TF_VAR_api_key="$PROD_API_KEY"
export TF_VAR_jwt_secret="$PROD_JWT_SECRET"

terraform apply -var-file="environments/production/terraform.tfvars"
```

## Security Checklist

- [ ] Secrets stored in AWS Secrets Manager
- [ ] IAM roles configured with minimal permissions
- [ ] Sensitive variables marked as sensitive
- [ ] State file encryption enabled
- [ ] Secrets files excluded from version control
- [ ] Runtime secret retrieval implemented
- [ ] Proper file permissions on configuration files
- [ ] Environment-specific secret management