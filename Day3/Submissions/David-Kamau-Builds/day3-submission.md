# Day 3 Submission

## Personal Information
- **Name:** David-Kamau-BUilds
- **Date:** 28th May 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [ ] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
    - VPC with DNS
    - Internet Access
    - Public Subnet
    - Security Group
    - Consistent Tagging: All resources tagged by (var.project_name) for easy tracking

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
    - Dynamic AMI Lookup
    - High Availability: Two AZs
    - Application Load Balancer
    - Auto Scaling Group
    - CloudWatch for scaling policies

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** From One to Many: Building a Scalable AWS Web Architecture with Terraform
- **Link:** https://medium.com/@davidwashingtonkamau/from-one-to-many-building-a-scalable-aws-web-architecture-with-terraform-51a9f6fc204b

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/posts/davidwashingtonkamau_hug-hashicorp-awsaimlke-activity-7333894344606707713-tS5v?utm_source=share&utm_medium=member_desktop&rcm=ACoAAE7Yhn0B4r6JF1eNqzo97b9jvzabJQMz9Z8

## Notes and Observations
- Used a data source to automatically grab the latest Amazon Linux 2 AMI.
- Created two public subnets (in different AZs) and attached them to a single route table and Internet Gateway for high availability.
- Split security groups: ALB SG allows HTTP from anywhere; Web SG allows HTTP only from the ALB and SSH from a locked-down IP.

## Additional Resources Used
- Stack Overflow & AWS re:Post: Troubleshooting specific Terraform/AWS errors (e.g., health check failures).
- Terraform AWS Provider Docs: Official reference for all resource arguments and examples.
- ChatGPT
- Youtube Tutorials.

## Time Spent
- Reading: [0 hours]
- Infrastructure Deployment: [2 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [1 hours]
- Total: [4 hours]

## Repository Structure
```
Day3/
└── Submissions/
    └── David-Kamau-Builds/
        ├── architecture/
        │   ├── single-server-application-architecture.png
        │   └── web-server-application-architecture.png
        ├── terraform/
        │   ├── single-server/
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   ├── provider.tf
        │   │   ├── terraform.tfvars
        │   │   ├── variables.tf
        │   │   ├── versions.tf
        │   │   └── README.MD
        │   └── web-server/
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── provider.tf
        │       ├──terraform.tfvars
        │       ├── variables.tf
        │       ├── versions.tf
        │       └── README.MD
        └── day3-submission.md
``` 