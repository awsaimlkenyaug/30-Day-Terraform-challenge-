# Day 10 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 6th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 5 (Pages 141-160)
- [x] Completed Required Hands-on Labs
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Web Server Deployment
- **Region:** us-west-2
- **Instance Type:** t2-micro
- **Key Features:** ALB, S3 bucket and DynamoDB table for state file and locking

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** How Loops and Conditionals Simplify Infrastructure as Code with Terraform
- **Link:** https://simiops.hashnode.dev/how-loops-and-conditionals-simplify-infrastructure-as-code-with-terraform?showSharer=true

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1931811337828475098

## Notes and Observations
- Worked on Loops and conditionals to create dynamic configurations.
- Implemented a more modular approach to Terraform configurations.


## Additional Resources Used
- Terraform Documentation: https://www.terraform.io/docs

## Time Spent
- Reading: [2 hours]
- Infrastructure Deployment: [3 hours]
- Diagram Creation: [1 hour]
- Blog Writing: [2 hours]
- Total: [8 hours]

## Repository Structure
```
Day10/
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



