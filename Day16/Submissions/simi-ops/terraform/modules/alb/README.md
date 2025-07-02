# ALB Module

## Description
Production-grade Application Load Balancer module with environment-specific configurations.

## Version
v2.0.0

## Usage
```hcl
module "alb" {
  source = "./modules/alb"
  
  environment       = "production"
  name_prefix       = "myapp-web"
  security_group_id = module.security_group.security_group_id
  enable_stickiness = true
  
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}
```

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| environment | Environment name | string | n/a | yes |
| name_prefix | Prefix for resource names | string | n/a | yes |
| security_group_id | Security group ID for ALB | string | n/a | yes |
| enable_stickiness | Enable session stickiness | bool | false | no |
| tags | Tags to apply to resources | map(string) | {} | no |

## Outputs
| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the load balancer |
| alb_zone_id | Zone ID of the load balancer |
| target_group_arn | ARN of the target group |

## Features
- Environment-specific health check intervals
- Conditional deletion protection for production
- Session stickiness support
- Comprehensive tagging