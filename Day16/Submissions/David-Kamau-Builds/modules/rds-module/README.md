# RDS Module

This module creates an RDS instance with associated security groups and subnet groups in AWS.

## Features

- Creates an RDS instance with MySQL 8.0
- Sets up a security group for database access
- Creates a DB subnet group
- Configures encrypted storage
- Manages database credentials securely

## Usage

```hcl
module "rds" {
  source = "./modules/rds-module"

  name_prefix = "my-app"
  environment = "prod"
  region      = "us-east-1"
  username    = var.db_username
  password    = var.db_password
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
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
| username | Database username | string | yes |
| password | Database password | string | yes |
| vpc_id | ID of the VPC where the database will be created | string | yes |
| subnet_ids | List of subnet IDs where the database can be placed | list(string) | yes |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_endpoint | The connection endpoint for the database |
| db_instance_id | The ID of the database instance |
| db_security_group_id | The ID of the database security group |

## Security Features

- Storage encryption enabled by default
- Security group with restricted access
- Credentials handled as sensitive values
- Skip final snapshot for easier cleanup (configurable)

## Tags

All resources are tagged with:
- Name
- Environment
- ManagedBy = "Terraform"
- Region
- Project = "MultiRegionDeployment"