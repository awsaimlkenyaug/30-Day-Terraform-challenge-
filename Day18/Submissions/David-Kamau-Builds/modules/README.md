# Terraform Modules

This directory contains reusable Terraform modules for deploying infrastructure components.

## Module Overview

| Module | Description | Dependencies | Limitations |
|--------|-------------|--------------|------------|
| `vpc-module` | Creates VPC, subnets, and security groups | None | Uses placeholder ARNs for WAF and ALB |
| `rds-module` | Creates RDS database with security best practices | vpc-module | Requires security group IDs |
| `eks-module` | Creates EKS cluster with security best practices | vpc-module | Kubernetes resources require kubectl |
| `blue-green-module` | Implements blue-green deployment strategy | vpc-module, secrets-module | Requires ALB and security groups |
| `secrets-module` | Manages secrets in AWS Secrets Manager | None | Contains placeholder secrets |
| `gcp-module` | Creates GCP resources including GKE | None | Requires GCP account |

## Security Features

All modules implement security best practices:

- Encryption at rest
- Network security
- IAM authentication
- Monitoring and logging
- Compliance with security standards

## Module Usage

Each module can be used independently or together. See individual module README files for specific usage instructions.

## Testing

Modules can be tested individually:

```bash
cd vpc-module
terraform init
terraform validate
terraform plan
```

## Known Issues

1. **Circular Dependencies**:
   - Some modules have circular dependencies that require careful ordering
   - Use `depends_on` or output values to manage dependencies

2. **Default Values**:
   - Some modules use placeholder values that should be replaced in production
   - Review all variables before deployment

3. **Resource Naming**:
   - Resource names may exceed AWS/GCP length limits in some cases
   - Consider shorter name prefixes for production

4. **Test Mode Limitations**:
   - Test mode uses placeholder values that may not validate in all contexts
   - Some resources cannot be fully validated without creation