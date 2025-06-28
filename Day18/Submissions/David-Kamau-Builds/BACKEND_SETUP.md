# Backend Configuration Guide

This project supports both local and S3 backends for Terraform state management. The backend configuration can be switched using the provided scripts.

## Backend Types

### Local Backend

- **Use Case**: Development, testing, and CI/CD pipelines
- **Configuration**: Minimal configuration, state stored locally
- **Pros**: Simple setup, no external dependencies
- **Cons**: No state locking, no remote collaboration

### S3 Backend

- **Use Case**: Production deployments, team collaboration
- **Configuration**: Requires S3 bucket and DynamoDB table
- **Pros**: State locking, versioning, team collaboration
- **Cons**: Requires AWS credentials, additional setup

## Switching Between Backends

Use the provided scripts to switch between backend configurations:

```bash
# Windows
cd scripts
switch-backend.bat local  # Switch to local backend
switch-backend.bat s3     # Switch to S3 backend

# Linux/macOS
cd scripts
./switch-backend.sh local  # Switch to local backend
./switch-backend.sh s3     # Switch to S3 backend
```

## S3 Backend Setup

Before using the S3 backend, you must create the required resources:

1. Create an S3 bucket:
   ```bash
   aws s3api create-bucket --bucket dkb-terraform-state --region us-east-1
   ```

2. Enable versioning on the bucket:
   ```bash
   aws s3api put-bucket-versioning --bucket dkb-terraform-state --versioning-configuration Status=Enabled
   ```

3. Create a DynamoDB table for state locking:
   ```bash
   aws dynamodb create-table \
     --table-name dkb-terraform-locks \
     --attribute-definitions AttributeName=LockID,AttributeType=S \
     --key-schema AttributeName=LockID,KeyType=HASH \
     --billing-mode PAY_PER_REQUEST \
     --region us-east-1
   ```

## CI/CD Pipeline Configuration

The GitHub Actions workflow is configured to use the local backend. No additional setup is required for CI/CD.

## Troubleshooting

If you encounter backend initialization issues:

1. Check that you're using the correct backend configuration
2. Verify AWS credentials if using S3 backend
3. Ensure S3 bucket and DynamoDB table exist
4. Run `terraform init -reconfigure` to force backend reconfiguration