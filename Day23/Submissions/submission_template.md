# Day 23 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-29
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - VPC with subnet
  - Internet connectivity via IGW
  - EC2 instance with SSH access only

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - VPC with subnet
  - Public IP with IGW and routing
  - EC2 instance with NGINX via user_data
  - Security group for HTTP (80) and SSH (22)

## Infrastructure Diagrams
- `architecture/single-server.png`
- `architecture/web-server.png`

## Blog Post
- **Title:** Preparing for the Terraform Associate Exam – Key Concepts & Strategy
- **Link:** [https://medium.com/@ngumonelson123/terraform-associate-exam-prep](https://medium.com/@ngumonelson123/terraform-associate-exam-prep)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/ngumonelson123](https://linkedin.com/in/ngumonelson123)

## Notes and Observations
- Realized AWS accounts may lack default VPC — resolved by defining custom VPC.
- Confident deploying end-to-end infrastructure with Terraform.
- Reviewed key concepts like provider aliasing, user_data, remote backends, and workspaces.

## Additional Resources Used
- HashiCorp Docs: Terraform Associate Study Guide
- YouTube: Terraform Bootcamp by FreeCodeCamp
- Community Discord Discussions

## Time Spent
- Reading: 1.5 hours
- Infrastructure Deployment: 2 hours
- Diagram Creation: 0.5 hours
- Blog Writing: 1 hour
- Total: 5 hours

## Repository Structure
Day23/
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