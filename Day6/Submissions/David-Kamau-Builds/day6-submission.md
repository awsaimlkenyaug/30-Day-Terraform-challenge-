# Day 6 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** 1st June 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [ ] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
    - Free Tier–Eligible EC2
    - Security group
    - Elastic IP
    - Output Values: Exposes instance_id, public_ip, and public_dns after apply.

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** 
    - Remote State Management
    - Launch Template
    - Output Values: Exposes asg_name, launch_template_id, alb_dns_name, security_group_id, and a list of current ASG instance IDs.

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
- Discovered AWS doesn’t offer a “default” certificate, so obtaining one means either using ACM (public, DNS-validated) or generating a self-signed cert on the instance.
- Faced confusion about free-tier eligibility but clarified that in us-east-1 both t2.micro and t3.micro qualify.
- Encountered Terraform’s two-step init when bootstrapping an S3 bucket and DynamoDB table for remote state, then re‐running terraform init to use that backend.

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Additional Resources Used
- AWS Certificate Manager documentation
- AWS free-tier FAQs to confirm t2.micro vs. t3.micro eligibility.

## Time Spent
- Reading: [2 hours]
- Infrastructure Deployment: [2.5 hours]
- Diagram Creation: [0 hours]
- Blog Writing: [0 hours]
- Total: [4.5 hours]

## Repository Structure
```
Day6/
└── Submissions/
    └── David-Kamau-Builds/
        ├── terraform/
        │   │   ├── single-server/
        │   │   ├── backend.tf
        │   │   ├── bootstrap.tf
        │   │   ├── main.tf
        │   │   ├── outputs.tf
        │   │   ├── providers.tf
        │   │   └── variables.tf
        │   └── web-server/
        │       ├── backend.tf
        │       ├── bootstrap.tf
        │       ├── main.tf
        │       ├── outputs.tf
        │       ├── providers.tf
        │       └──variables.tf
        └── day6-submission.md
``` 



