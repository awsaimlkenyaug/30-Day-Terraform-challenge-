# Day 8 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 4th June 2025
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
- **Title:** Building Reusable Infrastructure with Terraform Modules
- **Link:** https://simiops.hashnode.dev/building-reusable-infrastructure-with-terraform-modules

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1931343026699305030

## Notes and Observations
- Set up modules for EC2, Security Group, and ALB to modularize the Terraform code.
- Used variables for instance type and region to enhance flexibility.
- Implemented remote state management using S3 and DynamoDB for state locking.

## Additional Resources Used
- Terraform Documentation
- AWS Documentation

## Time Spent
- Reading: [1 hours]
- Infrastructure Deployment: [1 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [1 hours]
- Total: [4 hours]

## Repository Structure
```
Day8/
└── Submissions/
    └── simi-ops/
        ├── architecture/
        │   └── web-server.png
        ├── terraform/
        │   └── web-server/
        │       ├── main.tf
        │       ├── variables.tf
        │       ├── outputs.tf
        │       ├── modules/
        │       │   ├── ec2/
        │       │   │   ├── main.tf
        │       │   │   ├── variables.tf
        │       │   │   └── outputs.tf
        │       │   ├── security_group/
        │       │   │   ├── main.tf
        │       │   │   ├── variables.tf
        │       │   │   └── outputs.tf
        │       │   └── alb/
        │       │       ├── main.tf
        │       │       ├── variables.tf
        │       │       └── outputs.tf
        └── day8-SimiMwanza.md
``` 



