# Day 8 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 3, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server

## Infrastructure Details

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
  - Amazon Linux 2 AMI
  - Public IP address
  - SSH access via key pair
  - Security group configuration
  - Modular design with reusable EC2 instance module

## Notes and Observations
The modular approach to Terraform configuration allows for better code organization and reusability. I faced challenges with variable definitions between root and child modules, but resolved them by ensuring consistent variable declarations across modules.

## Additional Resources Used
- Terraform Documentation
- AWS EC2 Documentation

## Time Spent
- Reading: 1 hours
- Infrastructure Deployment: 2 hours
- Troubleshooting: 0.5 hour
- Total: 3.5 hours

## Repository Structure
```
David-Kamau-Builds/
├── modules/
│   └── ec2-module/
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── day8-submission.md
├── main.tf
├── provider.tf
├── README.md
├── terraform.tfvars
└── variables.tf
```