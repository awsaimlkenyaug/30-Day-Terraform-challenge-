# EC2 Web Module with Versioning and Terraform Loops

This project demonstrates module versioning, multi-environment deployment, and the use of Terraform loops and conditionals.

## Module Versioning

The module uses semantic versioning with different directories for each version:

- **v1.0.0**: Basic EC2 instance deployment with conditional creation using `count`
- **v1.1.0**: Enhanced security features with multiple instances using `for_each`
- **v2.0.0**: Auto-scaling with dynamic tags and conditional monitoring

## Environment-Specific Deployments

Each environment uses a different version of the module with different loop implementations:

- **Dev**: Uses v1.0.0 with `count` for conditional creation
- **Staging**: Uses v1.1.0 with `for_each` to create multiple instances
- **Production**: Uses v2.0.0 with dynamic blocks and conditional resources

## Terraform Loops and Conditionals

### Count (v1.0.0)
```hcl
resource "aws_instance" "this" {
  count = var.enabled ? 1 : 0
  
  # Resource configuration
  
  tags = {
    for key, value in {
      Name        = "${var.name_prefix}-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Version     = "1.0.0"
    } : key => value
  }
}
```

### For Each (v1.1.0)
```hcl
resource "aws_instance" "this" {
  for_each = var.instance_names

  # Resource configuration
  
  tags = {
    Name        = "${var.name_prefix}-${each.key}-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Version     = "1.1.0"
    Instance    = each.key
  }
}
```

### Dynamic Blocks (v2.0.0)
```hcl
resource "aws_autoscaling_group" "this" {
  # Resource configuration
  
  dynamic "tag" {
    for_each = {
      Name        = "${var.name_prefix}-${var.environment}"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Version     = "2.0.0"
    }
    
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
```

## Usage

### Dev Environment (Conditional Creation)
```hcl
module "web" {
  source             = "../modules/ec2-web-module/v1.0.0"
  name_prefix        = "dkb-web"
  environment        = "dev"
  subnet_id          = "subnet-12345678"
  security_group_ids = ["sg-12345678"]
  ssh_key_name       = "dev-key"
  enabled            = true  # Set to false to skip creation
}
```

### Staging Environment (Multiple Instances)
```hcl
module "web" {
  source             = "../modules/ec2-web-module/v1.1.0"
  name_prefix        = "dkb-web"
  environment        = "staging"
  subnet_id          = "subnet-12345678"
  security_group_ids = ["sg-12345678"]
  ssh_key_name       = "staging-key"
  instance_names     = ["main", "secondary"]  # Creates two instances
}
```

### Production Environment (Auto-scaling with Monitoring)
```hcl
module "web" {
  source             = "../modules/ec2-web-module/v2.0.0"
  name_prefix        = "dkb-web"
  environment        = "prod"
  subnet_id          = "subnet-12345678"
  security_group_ids = ["sg-12345678"]
  ssh_key_name       = "prod-key"
  instance_count     = 2
  enable_monitoring  = true  # Set to false to disable CloudWatch alarms
}
```

## Deployment Instructions

1. Navigate to the environment directory (dev, staging, or production)
2. Initialize Terraform: `terraform init`
3. Plan the deployment: `terraform plan`
4. Apply the configuration: `terraform apply`