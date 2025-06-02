# Day 2 Submission

## Personal Information
- **Name:** Samuel Macharia
- **Date:** Tue 27th May 2025
- **GitHub Username:** Engeniusam

## Task Completion
- [✅] Read Chapter 2 of "Terraform: Up & Running"
- [✅] Completed Required Hands-on Labs
- [✅] Deployed Single Server
- [✅] Deployed Web Server
- [✅] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **AMI:** ami-0c55b159cbfafe1f0 (Amazon Linux 2)
- **Key Features:**
  - Security Group: Allow SSH (port 22) and HTTP (port 80)
  - User Data Script: Install Apache web server
  - Tags: Name, Environment, Owner

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **AMI:** ami-0c55b159cbfafe1f0 (Amazon Linux 2)
- **Key Features:** [List key configurations]
  - Security Group: Allow SSH (port 22) and HTTP (port 80)
  - User Data Script: Install Apache web server
  - Tags: Name, Environment, Owner

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Step-by-Step Guide to Setting Up Terraform, AWS CLI, and Your AWS Environment
- **Link:** https://engeniusam.hashnode.dev/step-by-step-guide-to-setting-up-terraform-aws-cli-and-your-aws-environment

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/posts/engeniusam_terraformsetup-aws-devops-activity-7333107862979633152-cmXg?utm_source=share&utm_medium=member_desktop&rcm=ACoAACtVt-QBTUtYeTvR-UpJjur8rN4DrHJK85A

## Notes and Observations

Learnt how to get ami using this handy tool: (https://cloud-images.ubuntu.com/locator/ec2/)

## Additional Resources Used

"Terraform: Up & Running" by Yevgeniy (Jim) Brikman
Gemini Code Assist + GitHub Copilot

## Time Spent
- Reading: [1 hour]
- Infrastructure Deployment: [1 hour]
- Diagram Creation: [1 hours]
- Blog Writing: [2 hours]
- Total: [5 hours]

## Repository Structure
```
Day2/
└── Submissions/
    └── Engeniusam/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   └── main.tf
        │   └── web-server/
        │       └── main.tf
        └── submission_day2.md
```


