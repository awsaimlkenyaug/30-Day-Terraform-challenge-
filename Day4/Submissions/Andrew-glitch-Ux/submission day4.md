# Day 4 Submission

## Personal Information
- **Name:** [Andrew Muntet]  
- **Date:** [6/06/2025]  
- **GitHub Username:** [Andrew-glitch-ux]  

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** eu-north-1  
- **Instance Type:** t3.micro  
- **Key Features:** Deployed a single EC2 instance using parameterized variables, connected to a public subnet, and attached with a security group allowing SSH and HTTP access.

### Web Server Deployment
- **Region:** eu-north-1  
- **Instance Type:** t3.micro  
- **Key Features:** Clustered deployment using `count`, with reusable variables, shared security group, and S3 backend configured for state management with DynamoDB locking.

## Blog Post
- **Title:** [Your Blog Post Title]  
- **Link:** [URL to your blog post]  

## Social Media
- **Platform:** [Twitter/LinkedIn]  
- **Post Link:** [URL to your social media post]  

## Notes and Observations
- Learned the importance of reusable Terraform code using variables and the DRY principle.
- Understood how to deploy both a single and clustered web server setup on AWS.
- Practiced referencing existing infrastructure using data sources.
- Improved confidence in planning, applying, and managing infrastructure state.

## Additional Resources Used
- Terraform official documentation  
- Terraform: Up & Running by Yevgeniy Brikman  

## Time Spent
- Reading: 1 hour  
- Infrastructure Deployment: 1.5 hours  
- Diagram Creation: 30 minutes  
- Blog Writing: 0 hours  
- Total: 3 hours  

## Repository Structure
```
Day4/
└── Submissions/
└── Andrew-glitch-Ux/
        terraform
          LICENCE.txt\
          terraform-provider
        .terraform.lock.hcl
    ├── daily update.md
        main.tf
        submission day4.md
        terraform.tfvars
        variable.tf
        README.md
        submission_template.md
│   README.md
    tasks.md 
