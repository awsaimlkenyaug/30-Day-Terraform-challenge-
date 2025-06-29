# Day 17 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-29
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 9
- [x] Completed State Migration & Import Labs
- [x] Deployed Single and Web Server
- [x] Manual Tests Performed & Cleaned up

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** S3 backend, remote state

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** HTTP access, imported EC2

## Blog Post
- **Title:** The Importance of Manual Testing in Terraform
- **Link:** [https://yourblog.com/manual-testing-terraform](https://yourblog.com/manual-testing-terraform)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/nelson-ngumo/posts/xyz](https://linkedin.com/in/nelson-ngumo/posts/xyz)

## Notes and Observations
- Manual testing helps catch drift and configuration errors early.
- Importing existing resources was tricky; needed correct instance ID.
- Destroying infrastructure saves cost and avoids clutter.

## Additional Resources Used
- Terraform docs
- AWS Console

## Time Spent
- Reading: 1.5 hrs
- Infrastructure Deployment: 1 hr
- Diagram Creation: 0.5 hr
- Blog Writing: 1 hr
- Total: 4 hrs

## Repository Structure
Day17/
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