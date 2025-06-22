# Blue-Green Deployment Module

This module implements a blue-green deployment strategy for applications in AWS using Application Load Balancer and Auto Scaling Groups.

## Features

- Creates an Application Load Balancer (ALB)
- Sets up blue and green target groups
- Configures launch templates for blue and green environments
- Implements auto scaling groups for each environment
- Provides traffic switching between blue and green deployments

## Usage

```hcl
module "deployment" {
  source = "./modules/blue-green-module"
  
  name_prefix        = "my-app"
  environment        = "prod"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.web_security_group_id]
  ssh_key_name       = "my-key"
  instance_count     = 2
  active_deployment  = "blue"
  blue_version       = "1.0.0"
  green_version      = "1.1.0"
  
  instance_profile_name = module.secrets.instance_profile_name
  secret_name           = module.secrets.secret_name
  region                = "us-east-1"
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
| vpc_id | ID of the VPC | string | yes |
| subnet_ids | List of subnet IDs | list(string) | yes |
| security_group_ids | List of security group IDs | list(string) | yes |
| ssh_key_name | Name of the SSH key pair | string | yes |
| instance_count | Number of instances in the active environment | number | yes |
| active_deployment | Which deployment is active ("blue" or "green") | string | yes |
| blue_version | Version for the blue environment | string | yes |
| green_version | Version for the green environment | string | yes |
| instance_profile_name | Name of the IAM instance profile | string | no |
| secret_name | Name of the secret in AWS Secrets Manager | string | no |
| region | AWS region | string | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the load balancer |
| active_deployment | Currently active deployment (blue or green) |
| active_version | Version of the currently active deployment |

## Security Features

- HTTPS support
- Security groups with restricted access
- IAM roles with least privilege
- Encrypted EBS volumes

## Tags

All resources are tagged with:
- Name
- Environment
- ManagedBy = "Terraform"
- Deployment = "blue" or "green"
- Version