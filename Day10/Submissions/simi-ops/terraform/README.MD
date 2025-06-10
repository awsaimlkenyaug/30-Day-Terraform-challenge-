# 30-Day Terraform Challenge - Enhanced Multi-Environment Infrastructure

This repository contains an enhanced Terraform configuration with support for multiple environments (dev, staging, production) and module versioning.

## Repository Structure

```
terraform/
├── main.tf                     
├── variables.tf                
├── deploy.sh                   
├── README.md                   
├── environments/               
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── production/
│       └── terraform.tfvars
├── modules/                   
│   ├── alb/                   
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/                   
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data.sh
│   └── security_group/       
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

```

## Features

- ✅ **Multi-environment support** (dev, staging, production)
- ✅ **Module versioning** with consistent tagging
- ✅ **Environment-specific configurations**
- ✅ **Automated deployment scripts**
- ✅ **Cost optimization** with environment-specific instance types
- ✅ **Security best practices** with environment-specific access controls
- ✅ **Consistent resource naming** with environment prefixes

## Quick Start

### Prerequisites
- Terraform 1.0 or higher
- AWS CLI configured with appropriate credentials
- Make sure you have the necessary permissions to create resources in AWS
- S3 bucket and DynamoDB table for remote state management
- Ensure you have the necessary IAM roles and policies for EC2, ALB, and Security Groups
### Initialize Terraform

```bash
# Make script executable
chmod +x deploy.sh

# Deploy to different environments
./deploy.sh dev plan
./deploy.sh dev apply   
./deploy.sh staging plan
./deploy.sh staging apply
./deploy.sh production plan
./deploy.sh production apply
```


## Environment Differences

| Environment | Instance Type | Region    | SSH Access    | ALB Protection |
|-------------|---------------|-----------|---------------|----------------|
| dev         | t3.micro      | us-west-2 | 0.0.0.0/0     | Disabled       |
| staging     | t3.small      | us-west-2 | 0.0.0.0/0     | Disabled       |
| production  | t3.medium     | us-east-1 | 10.0.0.0/8    | Enabled        |

## Module Versions

All modules are tagged with version 1.0.0 and include:
- Consistent variable interfaces
- Comprehensive outputs
- Environment-aware configurations
- Proper resource tagging

## Cleanup

To remove all resources:

```bash
./scripts/deploy.sh dev destroy
./scripts/deploy.sh staging destroy
./scripts/deploy.sh production destroy
```
