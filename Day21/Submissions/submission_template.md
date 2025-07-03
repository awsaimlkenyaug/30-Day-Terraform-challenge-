# Day 21 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-29
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 10 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** EC2 instance in custom VPC, SSH access, public IP, security group defined via Terraform

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Apache installed using user_data, accessible on port 80, fully automated setup

## Infrastructure Diagrams
- `architecture/single-server.png`
- `architecture/web-server.png`

## Blog Post
- **Title:** A Workflow for Deploying Infrastructure Code with Terraform
- **Link:** [To be added]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [To be added]

## Notes and Observations
- Creating custom networking was necessary due to lack of default VPC
- Learned how to attach multiple security groups and troubleshoot port access issues
- Cost estimation and Sentinel policies provide strong governance

## Additional Resources Used
- AWS EC2 Docs
- Terraform Registry
- ChatGPT 🤝

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 20 mins
- Blog Writing: 30 mins
- Total: 4 hours

## Repository Structure
Day21/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ ├── single-server.png
│ └── web-server.png
├── terraform/
│ ├── single-server/
│ │ └── main.tf
│ └── web-server/
│ └── main.tf
└── submission.md