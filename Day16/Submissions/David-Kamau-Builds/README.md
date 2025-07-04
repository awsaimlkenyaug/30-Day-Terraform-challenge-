# Production-Grade Terraform Infrastructure

This repository contains production-grade Terraform infrastructure code for deploying multi-region and multi-cloud resources.

## Architecture

The infrastructure is designed with the following components:

- **Multi-Region AWS Resources**: VPCs, RDS instances, and application deployments in us-east-1 and us-west-2
- **Google Cloud Platform Resources**: VPC network, subnet, and GKE cluster
- **Blue-Green Deployment**: Application deployment strategy with zero-downtime updates
- **Secrets Management**: Secure handling of sensitive information

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
└── tests/                   # Terratest test files
```

## Getting Started

### Prerequisites

- Terraform 1.5.0 or later
- AWS CLI configured with appropriate credentials
- Google Cloud SDK configured with appropriate credentials
- Go 1.19 or later (for running tests)

### Setup

1. Set up remote state:
   ```bash
   cd remote-state
   terraform init
   terraform apply
   ```

2. Deploy the infrastructure:
   ```bash
   cd production
   terraform init
   terraform plan
   terraform apply
   ```

## Testing

Run the tests using Terratest:

```bash
cd tests
go test -v
```

## CI/CD Pipeline

The repository includes a GitHub Actions workflow that:

1. Validates Terraform code
2. Runs tests
3. Creates a plan
4. Applies changes (on merge to main)

## Best Practices Implemented

- **Modularity**: Code is organized into reusable modules
- **Remote State**: State is stored in S3 with locking via DynamoDB
- **Testing**: Infrastructure is tested using Terratest
- **CI/CD**: Changes are validated and applied through a CI/CD pipeline
- **Documentation**: Each module includes comprehensive documentation
- **Version Control**: All modules specify version constraints
- **Security**: Secrets are managed securely, resources are properly secured
