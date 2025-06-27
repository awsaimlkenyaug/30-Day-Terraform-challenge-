# Day 11 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 6, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [x] Enhanced module from Day 8 with advanced features
- [x] Added module versioning support
- [x] Deployed infrastructure across different environments
- [x] Refactored code to use conditionals for dynamic infrastructure deployment
- [x] Ensured all instances are Free Tier eligible (t2.micro or t3.micro)
- [x] Used us-east-1 region for all deployments

## Infrastructure Details

### Module Versioning Implementation
- **Versioning Approach:** Local directory-based versioning (v1.0.0, v1.1.0, v2.0.0)
- **Module Location:** modules/ec2-web-module/
- **Key Features:** Progressive enhancements across versions

### Multi-Environment Deployment
- **Environments:** dev, staging, production
- **Region:** us-east-1 (for Free Tier eligibility)
- **Instance Types:** t2.micro (dev, staging), t3.micro (production) - all Free Tier eligible

### Conditional Deployment Features
- **Environment-Based Instance Types:** t2.micro for dev/staging, t3.micro for production
- **Conditional Resource Creation:** Load balancer only created in production
- **Environment-Specific Scripts:** Different setup scripts for each environment
- **Dynamic ASG Sizing:** Larger min/max values for production
- **Conditional Monitoring:** Enhanced monitoring for production

## Version Features

### v1.0.0 (Basic - Dev Environment)
- Simple EC2 instance deployment
- t2.micro instance type (Free Tier eligible)
- Basic tagging
- Conditional creation using count

### v1.1.0 (Enhanced Security - Staging Environment)
- IMDSv2 required (http_tokens = "required")
- EBS volume encryption
- t2.micro instance type (Free Tier eligible)
- Multiple instances using for_each

### v2.0.0 (Advanced - Production Environment)
- t3.micro instance type (Free Tier eligible)
- Conditional resource creation
- Environment-specific setup scripts
- Dynamic Auto Scaling Group sizing
- Enhanced monitoring for production

## Notes and Observations
The implementation demonstrates how to use conditionals to deploy different resources and configurations based on the environment while ensuring all resources remain Free Tier eligible. By using simple conditional expressions, the infrastructure adapts to the specific requirements of each environment.

Key implementation highlights:
- Used local variables to centralize conditional logic
- Created environment-specific setup scripts
- Used conditional expressions to determine resource properties
- Applied count for conditional resource creation
- Ensured all instance types are Free Tier eligible (t2.micro or t3.micro)
- Used us-east-1 region for all deployments


## Repository Structure
```
Day11/
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
        │           ├── version.tf
        │           └── scripts/
        │               ├── prod_setup.sh
        │               ├── staging_setup.sh
        │               └── dev_setup.sh
        ├── day11-submission.md
        └── README.md
```