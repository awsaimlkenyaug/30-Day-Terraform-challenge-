# Day 18 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-29
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 9 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Dynamic AMI, custom VPC, subnet, SSH-enabled Security Group, Terratest validation

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Similar structure, validated output, GitHub Actions automation

## Infrastructure Diagrams
- `architecture/single-server.png` - shows Terraform CLI deploying to VPC, EC2 tested via Terratest

## Blog Post
- **Title:** Automating Terraform Testing: From Unit Tests to End-to-End Validation
- **Link:** [https://medium.com/@ngumonelson123/terraform-day-18](https://medium.com/@ngumonelson123/terraform-day-18) *(Replace with actual link)*

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/nelson-ngumo/posts/day18-testing](https://linkedin.com/in/nelson-ngumo/posts/day18-testing) *(Replace with actual link)*

## Notes and Observations
- Terratest is a game-changer for validating Terraform infrastructure
- Learned to write Go tests that programmatically deploy and verify Terraform deployments
- Integrated GitHub Actions to run tests on every push, ensuring safer pipelines

## Additional Resources Used
- [Terratest Docs](https://terratest.gruntwork.io/)
- [Terraform CI/CD Guide](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
- [Go by Example](https://gobyexample.com/)

## Time Spent
- Reading: 1 hr
- Infrastructure Deployment: 1.5 hrs
- Diagram Creation: 30 min
- Blog Writing: 1 hr
- Total: 4 hrs

## Repository Structure
Day18/
└── Submissions/
└── ngumonelson123/
├── terraform/
│ ├── single-server/
│ │ ├── main.tf
│ │ └── test/
│ │ └── main_test.go
├── .github/
│ └── workflows/
│ └── test.yml
├── architecture/
│ └── single-server.png
└── submission.md