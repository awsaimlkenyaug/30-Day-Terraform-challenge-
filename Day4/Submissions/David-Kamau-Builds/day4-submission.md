# Day 4 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** 31st May 2025
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
    - Custom VPC
    - Public subnet
    - Security groups for HTTP/HTTPS traffic
    - Amazon Linux 2 
    - Apache web server
    - 8GB GP3 volume

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
    - VPC with public subnets
    - Application Load Balancer
    - Auto Scaling Group
    - EC2 instances with Apache
    - Security groups for HTTP/HTTPS traffic

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Deploying a Highly Available Web App on AWS Using Terraform
- **Link:** https://medium.com/@davidwashingtonkamau/deploying-a-solid-web-app-on-aws-even-if-youre-not-a-cloud-expert-78783053ee8e

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/posts/davidwashingtonkamau_hug-hashicorp-awsaimlke-activity-7333894344606707713-tS5v?utm_source=share&utm_medium=member_desktop&rcm=ACoAAE7Yhn0B4r6JF1eNqzo97b9jvzabJQMz9Z8

## Notes and Observations
- I mistakenly deployed to us-west-1 and spent 5 minutes looking for the services in management console but finally got my error and updated the code.

## Additional Resources Used
- Terraform Documentation

## Time Spent
- Reading: [0.5 hours]
- Infrastructure Deployment: [1.5 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [1 hours]
- Total: [4 hours]

## Repository Structure
```
Day4/
└── Submissions/
    └── David-Kamau-Builds/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   ├── providers.tf
        │   │   └── variables.tf
        │   └── web-cluster/
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── providers.tf
        │       └── variables.tf
        └── submission.md
``` 



