# Day 29 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** July 3, 2025
- **GitHub Username:** Ngumonelson123

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
  - Public subnet with internet access
  - Security group allowing SSH (port 22)
  - Remote backend for state management

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Security group allowing HTTP (port 80) and SSH
  - EC2 instance with user_data script to install Apache
  - Tags to identify the environment

## Infrastructure Diagrams
Please find the diagrams in the `architecture` folder:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Fine-tuning My Terraform Exam Prep with Practice Exams
- **Link:** [https://medium.com/@ngumonelson123/fine-tuning-my-terraform-exam-prep](https://medium.com/@ngumonelson123/fine-tuning-my-terraform-exam-prep)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://www.linkedin.com/posts/ngumonelson123_terraform-30daytfchallenge](https://www.linkedin.com/posts/ngumonelson123_terraform-30daytfchallenge)

## Notes and Observations
- Practice exams really helped me spot gaps in my knowledge on data sources and modules.
- I had to troubleshoot a `BucketNotEmpty` error during cleanup—learned about force delete option and S3 lifecycle rules.
- Improved my diagramming skills using draw.io.

## Additional Resources Used
- [Terraform Registry](https://registry.terraform.io/)
- [Official HashiCorp Docs](https://developer.hashicorp.com/terraform/docs)
- YouTube: ExamPro's Terraform Associate prep series

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 1 hour
- Blog Writing: 1.5 hours
- Total: 5.5 hours

## Repository Structure
Day29/
└── Submissions/
└── Ngumonelson123/
├── architecture/
│ ├── single-server.png
│ └── web-server.png
├── terraform/
│ ├── single-server/
│ │ └── main.tf
│ └── web-server/
│ └── main.tf
└── submission.md