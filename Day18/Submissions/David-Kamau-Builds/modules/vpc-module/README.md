# VPC Module

This module creates a VPC with public subnets and associated resources in AWS.

## Features

- Creates a VPC with DNS support and DNS hostnames enabled
- Creates public subnets in specified availability zones
- Sets up an Internet Gateway
- Configures route tables for public subnets
- Creates security groups for web and ALB resources

## Usage

```hcl
module "vpc" {
  source = "./modules/vpc-module"

  name_prefix        = "my-app"
  environment        = "prod"
  region            = "us-east-1"
  cidr_block        = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
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
| region | AWS region | string | yes |
| cidr_block | CIDR block for the VPC | string | yes |
| availability_zones | List of availability zones to use | list(string) | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| public_subnet_ids | IDs of the public subnets |
| web_security_group_id | ID of the web security group |
| alb_security_group_id | ID of the ALB security group |

## Tags

All resources are tagged with:
- Name
- Environment
- ManagedBy = "Terraform"
- Region