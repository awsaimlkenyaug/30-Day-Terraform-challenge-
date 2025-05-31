# Day 5 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** 31st May 2025
- **GitHub Username:** David-Kamau-Builds

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
- **Title:** []
- **Link:** []

## Social Media
- **Platform:** []
- **Post Link:** []

## Notes and Observations
- Learned how to provision and scale a web server cluster using Terraform.
- Faced issues with state file locking and dependency ordering.

## Additional Resources Used
- Official Terraform documentation.
- HashiCorp Learn tutorials.
- GitHub community examples.

## Time Spent
- Reading: [4 hours]
- Infrastructure Deployment: [0.5 hours]
- Diagram Creation: [0.5 hours]
- Blog Writing: [0 hours]
- Total: [5 hours]

## Repository Structure
```
Day5/
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



