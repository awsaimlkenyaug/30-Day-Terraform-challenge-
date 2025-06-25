# EC2 Web Module with Versioning

This project demonstrates module versioning and multi-environment deployment using Terraform.

## Module Versioning

The module uses semantic versioning with different directories for each version:

- **v1.0.0**: Basic EC2 instance deployment
- **v1.1.0**: Enhanced security features (IMDSv2, EBS encryption)
- **v2.0.0**: Major update with auto-scaling and CloudWatch monitoring

## Environment-Specific Deployments

Each environment uses a different version of the module:

- **Dev**: Uses v1.0.0 (basic features)
- **Staging**: Uses v1.1.0 (enhanced security)
- **Production**: Uses v2.0.0 (auto-scaling and monitoring)

## Module Structure

```
modules/
└── ec2-web-module/
    ├── v1.0.0/
    │   ├── main.tf       # Basic EC2 instance
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── version.tf
    ├── v1.1.0/
    │   ├── main.tf       # EC2 with enhanced security
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── version.tf
    └── v2.0.0/
        ├── main.tf       # Auto-scaling group with monitoring
        ├── variables.tf
        ├── outputs.tf
        └── version.tf
```

## Usage

To use a specific version of the module:

```hcl
module "web" {
  source             = "../modules/ec2-web-module/v1.0.0"
  name_prefix        = "app-web"
  environment        = "dev"
  subnet_id          = "subnet-12345678"
  security_group_ids = ["sg-12345678"]
  ssh_key_name       = "my-key"
}
```

## Version Features

### v1.0.0 (Basic)
- Simple EC2 instance deployment
- Amazon Linux 2 AMI
- t2.micro instance type
- Basic tagging

### v1.1.0 (Enhanced Security)
- All features from v1.0.0
- IMDSv2 required (http_tokens = "required")
- EBS volume encryption
- Improved tagging

### v2.0.0 (Auto-scaling)
- Auto Scaling Group
- Launch Template
- CloudWatch monitoring
- CPU utilization alarms
- Configurable instance count

## Deployment Instructions

1. Navigate to the environment directory (dev, staging, or production)
2. Initialize Terraform: `terraform init`
3. Plan the deployment: `terraform plan`
4. Apply the configuration: `terraform apply`