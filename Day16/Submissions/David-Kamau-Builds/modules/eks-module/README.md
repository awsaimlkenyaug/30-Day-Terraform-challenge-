# EKS Module

This module creates an Amazon EKS (Elastic Kubernetes Service) cluster with associated resources in AWS.

## Features

- Creates an EKS cluster with managed node groups
- Sets up IAM roles and policies for EKS
- Configures security groups for cluster communication
- Implements proper tagging for resource management

## Usage

```hcl
module "eks_cluster" {
  source = "./modules/eks-module"

  name_prefix = "my-app"
  environment = "prod"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  
  providers = {
    aws = aws.east
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
| vpc_id | ID of the VPC where the EKS cluster will be created | string | yes |
| subnet_ids | List of subnet IDs where the EKS cluster will be deployed | list(string) | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster_name | Name of the EKS cluster |
| cluster_endpoint | Endpoint for the Kubernetes API server |
| cluster_certificate_authority_data | Base64 encoded certificate data for the cluster |

## Security Features

- IAM roles with least privilege
- Security groups with restricted access
- Encrypted communication

## Tags

All resources are tagged with:
- Name
- Environment
- ManagedBy = "Terraform"