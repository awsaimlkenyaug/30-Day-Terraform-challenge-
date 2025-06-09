# Day 9 Submission

## Personal Information
- **Name:** David Kamau
- **Date:** June 4, 2024
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [x] Enhanced module from Day 8 with advanced features
- [x] Added module versioning support
- [x] Deployed infrastructure across different environments
- [x] Implemented multi-environment support (dev, staging, production)

## Infrastructure Details

### Module Versioning Implementation
- **Versioning Approach:** Local directory-based versioning (v1.0.0, v1.1.0, v2.0.0)
- **Module Location:** modules/ec2-web-module/
- **Key Features:** Progressive enhancements across versions

### Multi-Environment Deployment
- **Environments:** dev, staging, production
- **Region:** us-east-1
- **Instance Types:** t2.micro (v1.0.0, v1.1.0), Auto Scaling Group (v2.0.0)

## Version Features

### v1.0.0 (Basic - Dev Environment)
- Simple EC2 instance deployment
- Amazon Linux 2 AMI
- Basic tagging

### v1.1.0 (Enhanced Security - Staging Environment)
- IMDSv2 required (http_tokens = "required")
- EBS volume encryption
- Improved tagging

### v2.0.0 (Auto-scaling - Production Environment)
- Auto Scaling Group
- Launch Template
- CloudWatch monitoring
- CPU utilization alarms

## Notes and Observations
The implementation demonstrates how to manage different versions of a module and deploy them across multiple environments. This approach allows for progressive enhancement of infrastructure while maintaining backward compatibility.

Key challenges included:
- Structuring the module versions to maintain consistency
- Ensuring each environment uses the appropriate module version
- Implementing meaningful enhancements between versions

## Time Spent
- Reading: [0 hours]
- Infrastructure Deployment: [4 hours]
- Total: [4 hours]

## Repository Structure
```
Day9/
└── Submissions/
    └── David-Kamau-Builds/
        ├── dev/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── terraform.tfvars
        ├── staging/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── terraform.tfvars
        ├── production/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── terraform.tfvars
        ├── modules/
        │   └── ec2-web-module/
        │       ├── v1.0.0/
        │       │   ├── main.tf
        │       │   ├── variables.tf
        │       │   ├── outputs.tf
        │       │   └── version.tf
        │       ├── v1.1.0/
        │       │   ├── main.tf
        │       │   ├── variables.tf
        │       │   ├── outputs.tf
        │       │   └── version.tf
        │       └── v2.0.0/
        │           ├── main.tf
        │           ├── variables.tf
        │           ├── outputs.tf
        │           └── version.tf
        ├── day9-submission.md  
        └── README.md
```