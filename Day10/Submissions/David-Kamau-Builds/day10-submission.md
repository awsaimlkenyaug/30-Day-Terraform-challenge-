# Day 10 Submission

## Personal Information

- **Name:** David Washington Kamau Kibe
- **Date:** June 5, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion

- [x] Enhanced module from Day 8 with advanced features
- [x] Added module versioning support
- [x] Deployed infrastructure across different environments
- [x] Implemented multi-environment support (dev, staging, production)
- [x] Refactored code to use loops and conditionals
- [x] Used count for conditional resource creation
- [x] Used for_each to iterate over maps/sets
- [x] Implemented conditional logic with variables

## Infrastructure Details

### Module Versioning Implementation

- **Versioning Approach:** Local directory-based versioning (v1.0.0, v1.1.0, v2.0.0)
- **Module Location:** modules/ec2-web-module/
- **Key Features:** Progressive enhancements across versions

### Multi-Environment Deployment

- **Environments:** dev, staging, production
- **Region:** us-east-1
- **Instance Types:** t2.micro (v1.0.0, v1.1.0), Auto Scaling Group (v2.0.0)

### Terraform Loops and Conditionals

- **Dev (v1.0.0):** Uses `count` for conditional resource creation based on `enabled` variable
- **Staging (v1.1.0):** Uses `for_each` to create multiple instances from a set of instance names
- **Production (v2.0.0):** Uses dynamic blocks for tags and conditional monitoring resources

## Version Features

### v1.0.0 (Basic - Dev Environment)

- Simple EC2 instance deployment with conditional creation using `count`
- Amazon Linux 2 AMI
- Basic tagging using `for` expressions
- Can be disabled with `enabled = false` variable

### v1.1.0 (Enhanced Security - Staging Environment)

- Multiple instances created with `for_each` loop
- IMDSv2 required (http_tokens = "required")
- EBS volume encryption
- Improved tagging with instance-specific names

### v2.0.0 (Auto-scaling - Production Environment)

- Auto Scaling Group with configurable instance count
- Launch Template
- Dynamic tag blocks using `for_each`
- Conditional CloudWatch monitoring using `count`
- CPU utilization alarms

## Notes and Observations

The implementation demonstrates how to manage different versions of a module and deploy them across multiple environments. This approach allows for progressive enhancement of infrastructure while maintaining backward compatibility.

Key challenges included:

- Structuring the module versions to maintain consistency
- Ensuring each environment uses the appropriate module version
- Implementing meaningful enhancements between versions
- Adapting outputs to handle conditional resources and collections
- Managing state when switching between count and for_each approaches

## Time Spent

- Reading: [0 hours]
- Infrastructure Deployment: [5 hours]
- Total: [5 hours]

## Repository Structure

```
Day10/
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
        ├── day10-submission.md
        └── README.md
```
