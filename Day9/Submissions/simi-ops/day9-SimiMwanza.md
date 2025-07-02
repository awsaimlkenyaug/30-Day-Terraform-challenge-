# Day 9 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 5th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [ ] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Web Server Deployment
- **Region:** us-west-2
- **Instance Type:** t2-micro
- **Key Features:** S3 bucket and DynamoDB table for state file and locking

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Advanced Terraform Module Usage: Versioning, Nesting, and Reuse Across Environments
- **Link:** https://simiops.hashnode.dev/advanced-terraform-module-usage-versioning-nesting-and-reuse-across-environments

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1931811337828475098

## Notes and Observations
- Worked in Nested Modules for better organization.
- Implemented versioning for modules to ensure stability across environments.
- Used environment-specific variables to customize deployments.

## Additional Resources Used
- Terraform Documentation
- AWS Documentation

## Time Spent
- Reading: [2 hours]
- Infrastructure Deployment: [5 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [2 hours]
- Total: [10 hours]

## Repository Structure
```
Day9/
└── Submissions/
    └── simi-ops/
        ├── architecture/
        │   └── web-server.png
        ├── terraform/
            ├── main.tf                     # Main Terraform configuration
            ├── variables.tf                # Variable definitions
            ├── README.md                   # This file
            ├── environments/               # Environment-specific configurations
            │   ├── dev/
            │   │   └── terraform.tfvars
            │   ├── staging/
            │   │   └── terraform.tfvars
            │   └── production/
            │       └── terraform.tfvars
            ├── modules/                    # Reusable Terraform modules
            │   ├── alb/                   # Application Load Balancer module
            │   │   ├── main.tf
            │   │   ├── variables.tf
            │   │   └── outputs.tf
            │   ├── ec2/                   # EC2 instance module
            │   │   ├── main.tf
            │   │   ├── variables.tf
            │   │   ├── outputs.tf
            │   │   └── user_data.sh
            │   └── security_group/        # Security Group module
            │       ├── main.tf
            │       ├── variables.tf
            │       └── outputs.tf
            └── scripts/                   # Deployment scripts
                └── deploy.sh
        └── day9-SimiMwanza.md
``` 



