# Auto Scaling Group Module

## Description
Production-grade Auto Scaling Group module with launch templates and zero-downtime deployment capabilities.

## Version
v2.0.0

## Usage
```hcl
module "asg" {
  source = "./modules/asg"
  
  environment       = "production"
  name_prefix       = "myapp-web"
  ami_id           = "ami-12345678"
  instance_type    = "t3.medium"
  security_group_id = module.security_group.security_group_id
  min_size         = 3
  max_size         = 6
  desired_capacity = 3
  target_group_arns = [module.alb.target_group_arn]
  
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
| ami_id | AMI ID for launch template | string | n/a | yes |
| instance_type | EC2 instance type | string | n/a | yes |
| security_group_id | Security group ID | string | n/a | yes |
| min_size | Minimum instances in ASG | number | n/a | yes |
| max_size | Maximum instances in ASG | number | n/a | yes |
| desired_capacity | Desired instances in ASG | number | n/a | yes |
| target_group_arns | Target group ARNs | list(string) | [] | no |
| tags | Tags to apply to resources | map(string) | {} | no |

## Outputs
| Name | Description |
|------|-------------|
| asg_name | Name of the Auto Scaling Group |
| asg_arn | ARN of the Auto Scaling Group |
| launch_template_id | ID of the launch template |
| launch_template_name | Name of the launch template |

## Features
- Launch Templates with create_before_destroy
- Rolling instance refresh for zero-downtime updates
- Environment-specific scaling policies
- CloudWatch alarms for auto-scaling
- EBS encryption for production