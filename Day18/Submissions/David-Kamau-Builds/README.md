# Production-Grade Terraform Infrastructure

This repository contains production-grade Terraform infrastructure code for deploying multi-region and multi-cloud resources with comprehensive automated testing.

## Architecture

The infrastructure is designed with the following components:

- **Multi-Region AWS Resources**: VPCs, RDS instances, and application deployments in us-east-1 and us-west-2
- **Google Cloud Platform Resources**: VPC network, subnet, and GKE cluster (requires GCP account)
- **Blue-Green Deployment**: Application deployment strategy with zero-downtime updates
- **Secrets Management**: Secure handling of sensitive information
- **Comprehensive Testing**: Unit, integration, and end-to-end tests

## Repository Structure

```
.
├── .github/workflows/       # CI/CD pipeline configuration
├── modules/                 # Reusable Terraform modules
│   ├── blue-green-module/   # Blue-green deployment module
│   ├── eks-module/          # EKS cluster module
│   ├── gcp-module/          # Google Cloud Platform module
│   ├── rds-module/          # RDS database module
│   ├── secrets-module/      # Secrets management module
│   └── vpc-module/          # VPC networking module
├── production/              # Production environment configuration
├── remote-state/            # Remote state management
├── scripts/                 # Test runner and utility scripts
├── tests/                   # Terratest test files
└── BACKEND_SETUP.md         # Backend configuration guide
```

## Prerequisites

- Terraform 1.5.0 or later
- AWS CLI configured with appropriate credentials
- Go 1.21 or later (for running tests)
- GCP account and credentials (only if deploying GCP resources)

## Getting Started

### Backend Setup

This project supports both local and S3 backends. See [BACKEND_SETUP.md](BACKEND_SETUP.md) for details.

### Deployment

1. Switch to the appropriate backend:
   ```bash
   cd scripts
   ./switch-backend.sh local  # For local development
   # OR
   ./switch-backend.sh s3     # For production deployment
   ```

2. Deploy the infrastructure:
   ```bash
   cd production
   terraform init
   terraform plan -var="deployment_mode=test"  # Test mode, no resources created
   terraform apply -var="deployment_mode=deploy"  # Deploy actual resources
   ```

## Testing

Run tests using the provided scripts:
```bash
cd scripts
./run-tests.sh  # Linux/macOS
# OR
run-tests.bat   # Windows
```

## Known Limitations and Shortcomings

1. **GCP Module Limitations**:
   - Requires a GCP account and project setup
   - Uses placeholder values for Google Groups RBAC
   - May require additional configuration for production use

2. **Security Considerations**:
   - Placeholder ARNs are used for WAF and ALB resources
   - Default passwords and secrets should be replaced in production
   - Some security features require additional AWS services

3. **Testing Limitations**:
   - Integration tests may timeout in CI/CD environments
   - End-to-end tests require actual AWS resources
   - Test coverage is not comprehensive

4. **Backend Configuration**:
   - S3 backend requires manual bucket and DynamoDB table setup
   - Switching between backends requires manual intervention

5. **CI/CD Pipeline**:
   - GitHub Actions workflow uses test mode only
   - No actual deployment in CI/CD pipeline
   - Requires AWS credentials for full testing

6. **Module Dependencies**:
   - Some modules have circular dependencies that require careful ordering
   - Count conditions may cause validation issues in certain scenarios

7. **Documentation**:
   - Some modules lack detailed documentation
   - Configuration examples are minimal

## Best Practices Implemented

- **Modularity**: Code is organized into reusable modules
- **Security**: Enhanced security settings for all resources
- **Testing**: Infrastructure is tested using Terratest
- **CI/CD**: Changes are validated through a CI/CD pipeline
- **Multi-Region**: Resources are deployed across multiple regions
- **Test Mode**: Supports testing without creating resources