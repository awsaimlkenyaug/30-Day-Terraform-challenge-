# Day 9 Submission

## Personal Information
- **Name:** julietwainoi
- **Date:** Date 7 2025
- **GitHub Username:** julietwainoi

## Task Completion
 - [x] I have continued reading Chapter 4 of "Terraform: Up & Running".
 - [x] I have completed the required hands-on labs
 - [x] I have enhanced my Terraform module to support versioning and multiple environments.
 - [x] I have refactored my Terraform module for the Bonus Hands-On     Project and deployed infrastructure across environments.
 - [x] I have written and published a blog post about today's task.
 - [x] I have made a social media post about today's task.
 - [ ] I have created a day9-update-your-github-username.md file with my Terraform code and architecture diagrams.
 - [ ] I have created a pull request with all the required details.

## Infrastructure Details

### terraform aws ec2 instance module Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** configured ouptputs.tf,main.tf,variables.tf

### terraform e2 environments Deployment
- **Key Features:** configured Dev,staging,and prod environment

## Blog Post
- **Title:** Advanced Terraform Module Usage: Versioning, Nesting, and Reuse Across Environments
- **Link:** https://julietwainoi.github.io/blog9.html

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/in/juliet-wainoi/

## Notes and Observations
my challenge is  how do i make sure no  much cost is incured while deploying these labs?this is coming form a point of concern if i have to deploy each lab.

## Additional Resources Used
terraform documentation.

## Time Spent
- Reading:2 hours
- Infrastructure Deployment: 0.5 hours
- Diagram Creation: [X hours]
- Blog Writing: 0.5 hours
- Total: 3 hours

## Repository Structure
```
Day9/
└── Submissions/
    └── julietwainoi
        ├── terraform/terraform-ec2-instance/
        │   ├── main.tf
        │   └── outputs.tf
        ├── terraform/terraform-ec2-environmets/
        │   ├── Dev/
        │   │   └── main.tf
        │   └── staging/
        │        └── main.tf
        │    └── prod/
        │       └── main.tf   
        │ 
        └── Day9_submission.md
``` 



