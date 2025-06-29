# Day 16 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-28
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 8 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [ ] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Automated VPC, Subnet, Internet Gateway
  - Public Subnet with SSH-enabled Security Group
  - EC2 Instance provisioned with tagged name
  - Terraform-managed state in S3 + DynamoDB

## Infrastructure Diagrams
- `single-server.png` saved in `architecture/`

## Blog Post
- **Title:** Building Production-Grade Infrastructure with Terraform
- **Link:** [Add your blog post URL]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [Add your LinkedIn post URL]

## Notes and Observations
- Learned how to modularize infrastructure for reusability.
- Faced VPC-related deployment errors but resolved with full automation.
- Understanding backend state and remote locking was crucial.

## Additional Resources Used
- Terraform Docs
- AWS Docs on VPC and Subnetting
- HashiCorp Learn Tutorials

## Time Spent
- Reading: 1.5 hours
- Infrastructure Deployment: 2 hours
- Diagram Creation: 30 mins
- Blog Writing: 45 mins
- Total: ~4.75 hours

## Repository Structure
Day16/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ └── single-server.png
├── terraform/
│ ├── single-server/
│ │ └── main.tf
│ └── web-server/
│ └── main.tf
└── submission.md