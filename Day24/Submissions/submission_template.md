# Day 24 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-30
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
  - Custom VPC and Subnet
  - Internet Gateway for public access
  - SSH-accessible EC2 instance

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Custom VPC with full routing and IGW
  - EC2 instance with NGINX installed via user_data
  - Security Group for HTTP and SSH
  - Accessible via Public IP

## Infrastructure Diagrams
- `architecture/single-server.png` - Diagram for the single server deployment
- `architecture/web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** My Final Preparation for the Terraform Associate Exam
- **Link:** [https://medium.com/@ngumonelson123/terraform-final-prep](https://medium.com/@ngumonelson123/terraform-final-prep)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/ngumonelson123](https://linkedin.com/in/ngumonelson123)

## Notes and Observations
- Simulated the certification exam by reviewing Terraform commands, troubleshooting workflows, and verifying provider configurations.
- Revisited Sentinel policies, cost estimation, and remote backends to strengthen weak areas.
- Comfortable with real-world Terraform infrastructure deployments using modules and best practices.

## Additional Resources Used
- HashiCorp Certification Docs
- Community Terraform Practice Exams
- YouTube Tutorials by FreeCodeCamp and Cloud Engineer Bootcamps

## Time Spent
- Reading: 1 hour  
- Infrastructure Deployment: 2 hours  
- Diagram Creation: 0.5 hour  
- Blog Writing: 1 hour  
- Exam Simulation & Review: 1.5 hours  
- Total: 6 hours

## Repository Structure
Day24/
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