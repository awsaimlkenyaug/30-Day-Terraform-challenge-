# Terraform Module with Environment-Based Conditionals

This project demonstrates how to use conditionals in Terraform to deploy different resources and configurations based on the environment.

## Free Tier Eligibility

All instances in this project are configured to be Free Tier eligible:
- All environments use either `t2.micro` or `t3.micro` instance types
- All deployments are in the `us-east-1` region for Free Tier eligibility
- Storage volumes are kept within Free Tier limits

## Key Features

### 1. Environment-Based Instance Types

```hcl
locals {
  # Select instance type based on environment - using only Free Tier eligible types
  instance_type = var.environment == "prod" ? "t3.micro" : "t2.micro"
}
```

### 2. Conditional Resource Creation

```hcl
# Only create load balancer in production
resource "aws_lb" "this" {
  count = var.environment == "prod" ? 1 : 0
  
  # Resource configuration
}
```

### 3. Environment-Specific Scripts

```hcl
# Conditional user data based on environment
user_data = base64encode(
  var.environment == "prod" ? file("${path.module}/scripts/prod_setup.sh") : 
  var.environment == "staging" ? file("${path.module}/scripts/staging_setup.sh") : 
  file("${path.module}/scripts/dev_setup.sh")
)
```

### 4. Dynamic ASG Sizing

```hcl
resource "aws_autoscaling_group" "this" {
  min_size            = var.environment == "prod" ? 2 : 1
  max_size            = var.environment == "prod" ? 5 : 3
  # Other configuration
}
```

## Module Versioning

The module uses semantic versioning with different directories for each version:

- **v1.0.0**: Basic EC2 instance deployment (t2.micro)
- **v1.1.0**: Enhanced security features (t2.micro)
- **v2.0.0**: Environment-based conditional deployment (t2.micro/t3.micro)

## Environment-Specific Deployments

Each environment uses a different version of the module:

- **Dev**: Uses v1.0.0 with t2.micro instances
- **Staging**: Uses v1.1.0 with t2.micro instances
- **Production**: Uses v2.0.0 with t3.micro instances

## Usage

```hcl
module "web" {
  source             = "../modules/ec2-web-module/v2.0.0"
  name_prefix        = "dkb-web"
  environment        = "prod"  # Change to "staging" or "dev" as needed
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  ssh_key_name       = var.ssh_key_name
  instance_count     = var.instance_count
  enable_monitoring  = var.enable_monitoring
}
```

## Deployment Instructions

1. Navigate to the environment directory (dev, staging, or production)
2. Initialize Terraform: `terraform init`
3. Plan the deployment: `terraform plan`
4. Apply the configuration: `terraform apply`