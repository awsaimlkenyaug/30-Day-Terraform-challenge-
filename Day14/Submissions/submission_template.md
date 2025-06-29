# Day 14 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** June 26, 2025
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
- **Key Features:** Basic EC2 deployment using default AWS provider

### Web Server Deployment
- **Region:** VPC in us-east-1, EC2 in us-west-2
- **Instance Type:** t2.micro
- **Key Features:** Demonstrates use of multiple providers with aliases across AWS regions

## Infrastructure Diagrams
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment using multiple providers

## Blog Post
- **Title:** Getting Started with Multiple Providers in Terraform
- **Link:** [Add your blog post link]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [Add your LinkedIn or Twitter link]

## Notes and Observations
- Learned how to use multiple AWS providers using aliases
- Understood how Terraform separates provider blocks using `alias`
- Useful for multi-region or multi-account setups

## Additional Resources Used
- Terraform Provider Docs
- Terraform AWS Examples
- Book: Terraform: Up & Running

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 1.5 hours
- Diagram Creation: 30 mins
- Blog Writing: 1 hour
- Total: ~4 hours

## Repository Structure
```
Day14/
└── Submissions/
    └── ngumonelson123/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/main.tf
        │   └── web-server/main.tf
        └── submission.md
```