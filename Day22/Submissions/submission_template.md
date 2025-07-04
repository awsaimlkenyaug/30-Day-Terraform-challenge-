# Day 22 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** June 29, 2025
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
- **Key Features:**
  - Single EC2 instance behind security group
  - Public IP with SSH access allowed only from my IP
  - Tags for environment classification
  - User data script for automatic setup

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - EC2 instance with Nginx installed via user data
  - Custom security group allowing HTTP/SSH
  - Output values for public IP
  - Simple static web content served

## Infrastructure Diagrams
Placed under `architecture/`:
- `single-server.png`
- `web-server.png`

## Blog Post
- **Title:** Putting It All Together: Application & Infrastructure Workflows with Terraform
- **Link:** [https://medium.com/@ngumonelson123/putting-it-all-together-terraform-day-22-journey-aaa](#)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/ngumonelson123/posts/day22-terraform-final](#)

## Notes and Observations
- 📚 The final chapter tied all Terraform practices together—state management, CI/CD, Sentinel policies.
- 🚀 Most impactful moment: deploying both code and infra using a single pipeline via Terraform Cloud.
- 💡 Challenge: Debugging Sentinel policy failure due to incorrect conditions—solved by checking TFC logs.

## Additional Resources Used
- HashiCorp Learn - Sentinel Simulator
- Blog: [Gruntwork’s guide on Infra Pipelines](https://blog.gruntwork.io)
- Terraform Registry for module reusability

## Time Spent
- Reading: 1.5 hours  
- Infrastructure Deployment: 2 hours  
- Diagram Creation: 45 minutes  
- Blog Writing: 1 hour  
- **Total: 5.25 hours**

## Repository Structure
Day22/
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

Copy
Edit
