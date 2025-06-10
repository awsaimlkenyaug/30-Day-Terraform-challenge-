# Terraform File Layout Isolation

This directory demonstrates how to manage multiple environments using file layout isolation. Each environment (dev, staging, prod) has its own directory with separate state files, while sharing common reusable modules.

## Directory Structure

```
file-layout-isolation/
├── environments/
│   ├── dev/                    # Development environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars.example
│   ├── staging/                # Staging environment
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars.example
│   └── prod/                   # Production environment
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars.example
└── modules/
    ├── vpc/                    # VPC module
    ├── security-groups/        # Security groups module
    ├── compute/               # Compute resources module
    └── load-balancer/         # Load balancer module
```

## Architecture Overview

### Modules

1. **VPC Module** (`modules/vpc/`)
   - Creates VPC with public and private subnets
   - Configurable NAT Gateway support
   - Internet Gateway and route tables
   - Environment-specific CIDR blocks

2. **Security Groups Module** (`modules/security-groups/`)
   - Web tier security group (HTTP/HTTPS access)
   - Database tier security group (MySQL/PostgreSQL)
   - SSH access for administration

3. **Compute Module** (`modules/compute/`)
   - Auto Scaling Group with launch template
   - CloudWatch alarms for scaling policies
   - User data script for web server setup
   - Environment-specific instance configurations

4. **Load Balancer Module** (`modules/load-balancer/`)
   - Application Load Balancer (ALB)
   - Target groups with health checks
   - Listeners for HTTP traffic
   - Optional SSL/TLS termination

### Environment Configurations

#### Development Environment
- **Instance Type**: t2.micro (cost-optimized)
- **Scaling**: 1-3 instances
- **Features**: Basic setup, no NAT Gateway
- **Security**: Relaxed rules for development

#### Staging Environment
- **Instance Type**: t3.small
- **Scaling**: 1-5 instances
- **Features**: Production-like testing
- **Security**: Production-like security rules

#### Production Environment
- **Instance Type**: t3.medium
- **Scaling**: 2-10 instances
- **Features**: Full monitoring, deletion protection
- **Security**: Strict security rules, enhanced monitoring

## Usage

### Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform installed (version >= 1.0)
3. An AWS key pair for EC2 instances

### Environment Setup

1. **Choose an environment** (dev, staging, or prod):
   ```bash
   cd environments/dev  # or staging/prod
   ```

2. **Copy and configure variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your specific values
   ```

3. **Configure backend** (optional but recommended):
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "your-terraform-state-bucket"
       key            = "file-layout/dev/terraform.tfstate"  # Change per environment
       region         = "us-west-2"
       encrypt        = true
       dynamodb_table = "terraform-state-locks"
     }
   }
   ```

4. **Initialize and deploy**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Environment-Specific Deployment

#### Development Environment
```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars for development settings
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

#### Staging Environment
```bash
cd environments/staging
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars for staging settings
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

#### Production Environment
```bash
cd environments/prod
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars for production settings
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## Configuration Examples

### Development terraform.tfvars
```hcl
aws_region = "us-west-2"
project_name = "terraform-challenge"
environment = "dev"
vpc_cidr = "10.0.0.0/16"
instance_type = "t2.micro"
min_size = 1
max_size = 3
desired_capacity = 1
enable_nat_gateway = false
```

### Production terraform.tfvars
```hcl
aws_region = "us-west-2"
project_name = "terraform-challenge"
environment = "prod"
vpc_cidr = "10.2.0.0/16"
instance_type = "t3.medium"
min_size = 2
max_size = 10
desired_capacity = 4
enable_nat_gateway = true
enable_deletion_protection = true
```

## State Management

### Separate State Files
Each environment maintains its own state file:
- Development: `file-layout/dev/terraform.tfstate`
- Staging: `file-layout/staging/terraform.tfstate`
- Production: `file-layout/prod/terraform.tfstate`

### Backend Configuration
Configure S3 backend for remote state storage:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "file-layout/${var.environment}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
```

## Benefits of File Layout Isolation

### ✅ Advantages
1. **Complete Isolation**: Each environment has its own state file
2. **Independent Deployments**: Changes to one environment don't affect others
3. **Environment-Specific Configurations**: Different settings per environment
4. **Security**: Production state is completely separate from dev/staging
5. **Module Reusability**: Shared modules reduce code duplication
6. **Clear Structure**: Easy to understand and navigate
7. **Scalability**: Easy to add new environments

### ⚠️ Considerations
1. **Code Duplication**: Each environment has its own configuration files
2. **Maintenance**: Updates need to be applied to multiple environments
3. **Consistency**: Manual effort required to keep environments in sync
4. **State File Management**: Multiple state files to manage and backup

## Security Best Practices

1. **State File Security**: Use S3 bucket encryption and access controls
2. **Network Isolation**: Use VPCs with proper subnet segmentation
3. **Access Controls**: Implement least-privilege IAM policies
4. **Secret Management**: Use AWS Secrets Manager or Parameter Store
5. **Monitoring**: Enable CloudTrail and CloudWatch logging

## Monitoring and Alerting

- CloudWatch alarms for Auto Scaling policies
- Application Load Balancer health checks
- Instance-level monitoring with detailed CloudWatch metrics
- Optional: Integration with external monitoring tools

## Cleanup

To destroy an environment:
```bash
cd environments/[environment]
terraform destroy -var-file="terraform.tfvars"
```

## Troubleshooting

### Common Issues

1. **State File Conflicts**: Ensure each environment uses a unique state file path
2. **Resource Naming**: Use environment-specific naming to avoid conflicts
3. **CIDR Overlaps**: Ensure VPC CIDR blocks don't overlap between environments
4. **Capacity Limits**: Check AWS service limits for your account

### Useful Commands

```bash
# Check current state
terraform show

# List resources
terraform state list

# Import existing resources
terraform import aws_instance.example i-1234567890abcdef0

# Refresh state
terraform refresh
```

## Next Steps

1. Set up CI/CD pipelines for automated deployments
2. Implement infrastructure testing with tools like Terratest
3. Add monitoring and alerting configurations
4. Implement backup strategies for state files
5. Consider using Terraform Cloud or Enterprise for team collaboration

## Resources

- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform State Management](https://www.terraform.io/docs/language/state/index.html)
