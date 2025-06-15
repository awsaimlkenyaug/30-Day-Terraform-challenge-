# Day 8 Submission

## Personal Information
- **Name:** juliet wainoi
- **Date:** June 5 2025
- **GitHub Username:** julietwainoi

## Task Completion

- [x] I have read Chapter 4 of "Terraform: Up & Running".
- [x] I have completed the required hands-on labs
- [x] I have successfully created a Terraform module and deployed infrastructure using it.
- [x] I have refactored an existing Terraform configuration into a reusable module as part of the Bonus Hands-On Project.
- [x] I have written and published a blog post about today's task.
- [x] I have made a social media post about today's task.
- [x] I have created a day8-update-your-github-username.md file with my Terraform code and architecture diagrams.
- [x] I have created a pull request with all the required details.

## Infrastructure Details

### module Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** created ec2-instance module,main.tf,outputs.tf,variables.


## Blog Post
- **Title:** Building Reusable Infrastructure with Terraform Modules
- **Link:** https://julietwainoi.github.io/blog8.html


## Notes and Observations
it is better to have the remote setup if you are doing the project as a team otherwise if it is a personal project file-layout will do.

## Additional Resources Used
terraform cloud how to create organization,i'm still learning on this for remote state management.

## Time Spent
- Reading: 2 hours
- Infrastructure Deployment: 1 hours
- Diagram Creation: 0.5 hours
- Blog Writing: 0.5 hours
- Total: 4 hours

## Repository Structure
```
Day8/
└── Submissions/
    └── julietwainoi
        ├── terraform
        │   ├── modules/ec2-instance
        │   │                └── main.tf
        │   │                └── variables.tf
        │   │                └── outputs.tf
        │   └── main.tf
        │        
        └── Day8_submission.md
        


