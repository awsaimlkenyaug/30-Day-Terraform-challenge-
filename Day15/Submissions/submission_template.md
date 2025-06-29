# Day 15 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-26
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 7 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Deployed using module with provider aliasing, reusable design

### Web Server Deployment
- **Region:** us-west-2
- **Instance Type:** t2.micro
- **Key Features:** Separate provider alias, modular EC2 provisioning across region

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Scaling IaC with Terraform: Multi-Cloud & Local Container Deployment
- **Link:** [https://medium.com/@nelsonmbui88]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://www.linkedin.com/posts/nelson-ngumo-869033162_30dayterraformchallenge-terraform-iac-activity-7344112695010287617-mbHa?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAACbNrBEBpmqmiEP6hVsk2sv4gd_ZU_n3IzM]

## Notes and Observations
- Used provider aliases to manage multi-region EC2 provisioning
- Refactored EC2 provisioning into a reusable module
- Deployed Docker container using Terraform locally
- Deployed Kubernetes namespace using Terraform on Minikube
- Learned how to structure multi-cloud and local resources within a unified Terraform setup

## Additional Resources Used
- Terraform Docs on Providers & Modules
- Docker Provider Registry
- Kubernetes Provider Registry

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 1 hour
- Blog Writing: 1 hour
- Total: 5 hours

## Repository Structure
```
Day15/
└── Submissions/
    └── ngumonelson123/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   └── main.tf
        │   ├── web-server/
        │   │   └── main.tf
        │   └── kubernetes-cluster/
        │       └── main.tf
        └── submission.md
```