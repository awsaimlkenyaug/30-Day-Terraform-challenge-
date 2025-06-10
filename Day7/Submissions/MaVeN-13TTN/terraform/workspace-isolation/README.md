# Terraform Workspace Isolation

This directory demonstrates state isolation using Terraform workspaces. Each workspace maintains its own state file while sharing the same configuration code.

## Overview

Terraform workspaces allow you to manage multiple environments using a single configuration. Each workspace maintains its own state file, providing isolation between environments while sharing the same Terraform code.

## Architecture

The configuration creates:

- **VPC** with environment-specific CIDR blocks
- **Public and Private Subnets** 
- **Internet Gateway** and route tables
- **Auto Scaling Group** with environment-specific instance types and capacity
- **Application Load Balancer** 
- **Security Groups** for web traffic

### Environment-Specific Configurations

| Environment | Instance Type | ASG Capacity | VPC CIDR      |
|-------------|---------------|--------------|---------------|
| dev         | t2.micro      | 1-2          | 10.0.0.0/16   |
| staging     | t3.small      | 2-4          | 10.1.0.0/16   |
| prod        | t3.medium     | 3-10         | 10.2.0.0/16   |

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform >= 1.0 installed
3. S3 bucket and DynamoDB table for remote state (created in Day 6)

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Create and Switch to Workspaces

```bash
# List existing workspaces
terraform workspace list

# Create new workspaces
terraform workspace new dev
terraform workspace new staging  
terraform workspace new prod

# Switch between workspaces
terraform workspace select dev
```

### 3. Plan and Apply

```bash
# Plan for the current workspace
terraform plan

# Apply configuration
terraform apply

# View outputs
terraform output
```

### 4. Managing Multiple Environments

```bash
# Deploy to dev environment
terraform workspace select dev
terraform apply

# Deploy to staging environment  
terraform workspace select staging
terraform apply

# Deploy to production environment
terraform workspace select prod
terraform apply
```

### 5. View Current Workspace

```bash
# Show current workspace
terraform workspace show

# List all workspaces
terraform workspace list
```

## State File Isolation

Each workspace maintains its own state file:

```
# State file locations (in S3)
workspace-isolation/env:/dev/terraform.tfstate
workspace-isolation/env:/staging/terraform.tfstate  
workspace-isolation/env:/prod/terraform.tfstate
```

## Testing the Setup

1. Access the load balancer URL from the terraform output
2. The web page will display environment-specific information
3. Verify different configurations are applied per environment

## Workspace Commands Reference

```bash
# Create new workspace
terraform workspace new <name>

# List workspaces (* indicates current)
terraform workspace list

# Switch workspace
terraform workspace select <name>

# Show current workspace
terraform workspace show

# Delete workspace (must be empty)
terraform workspace delete <name>
```

## Advantages of Workspace Isolation

✅ **Single Configuration**: One set of Terraform files for all environments  
✅ **Easy Switching**: Simple commands to switch between environments  
✅ **Shared Modules**: Reuse the same code across environments  
✅ **State Isolation**: Separate state files prevent environment conflicts  

## Disadvantages

❌ **Shared Backend**: All environments use the same backend configuration  
❌ **Human Error**: Easy to apply changes to wrong environment  
❌ **Limited Flexibility**: Same code structure for all environments  
❌ **State File Management**: All state files in same backend location  

## Best Practices

1. **Always verify workspace** before running `terraform apply`
2. **Use consistent naming** for workspaces (dev, staging, prod)
3. **Add workspace checks** in your configuration when needed
4. **Document workspace-specific** configurations clearly
5. **Use different AWS accounts** for production isolation

## Cleanup

```bash
# Destroy resources in each workspace
terraform workspace select dev
terraform destroy

terraform workspace select staging  
terraform destroy

terraform workspace select prod
terraform destroy

# Delete empty workspaces
terraform workspace select default
terraform workspace delete dev
terraform workspace delete staging
terraform workspace delete prod
```

## Files

- `main.tf` - Main Terraform configuration with workspace logic
- `variables.tf` - Variable definitions
- `outputs.tf` - Output values
- `user_data.sh` - EC2 instance initialization script
- `terraform.tfvars.example` - Example variables file

## Directory Structure

```
workspace-isolation/
├── main.tf          # Main infrastructure configuration
├── variables.tf     # Variable definitions
├── outputs.tf       # Output definitions
├── terraform.tfvars # Default variable values
├── backend.tf       # Remote state configuration
└── README.md        # This file
```

## Workspaces Created

- **default**: Default workspace (not used for environments)
- **dev**: Development environment
- **staging**: Staging environment  
- **prod**: Production environment

## Usage

```bash
# Initialize Terraform
terraform init

# Create and switch to development workspace
terraform workspace new dev
terraform workspace select dev
terraform apply -var="environment=dev"

# Create and switch to staging workspace
terraform workspace new staging
terraform workspace select staging
terraform apply -var="environment=staging"

# Create and switch to production workspace
terraform workspace new prod
terraform workspace select prod
terraform apply -var="environment=prod"

# List all workspaces
terraform workspace list

# Show current workspace
terraform workspace show
```

## Key Features

1. **Single Configuration**: One set of Terraform files for all environments
2. **State Isolation**: Each workspace has its own state file
3. **Variable-based Customization**: Environment-specific configurations via variables
4. **Simple Management**: Easy switching between environments

## Workspace State Files

When using S3 backend, state files are stored as:
- `env:/dev/terraform.tfstate`
- `env:/staging/terraform.tfstate`
- `env:/prod/terraform.tfstate`

## Advantages

- ✅ Single codebase to maintain
- ✅ Easy environment switching
- ✅ Built-in state isolation
- ✅ Simple workspace commands

## Disadvantages

- ❌ Single point of failure (same code for all environments)
- ❌ Harder to implement environment-specific configurations
- ❌ Risk of accidentally affecting wrong environment
- ❌ Limited environment customization capabilities
