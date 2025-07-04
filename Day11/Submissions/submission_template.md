
# Day 11 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-25
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 5 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Conditional deployment using `count`, toggle with `create_instance` variable.

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro (only if environment is `prod`)
- **Key Features:** Environment-based deployment using conditional expressions.

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Mastering Loops and Conditionals in Terraform
- **Link:** [Your Blog Post URL]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [Your LinkedIn Post URL]

## Notes and Observations
Learned how to use `count`, `for_each`, and conditionals to control resource creation dynamically. Conditionals add flexibility for deploying infrastructure based on environment or flags.

## Additional Resources Used
- Terraform Docs on [Conditionals](https://developer.hashicorp.com/terraform/language/expressions/conditionals)
- Terraform Registry Examples

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 1 hour
- Diagram Creation: 20 mins
- Blog Writing: 30 mins
- Total: 2.5 hours

## Repository Structure
```
Day11/
└── Submissions/
    └── ngumonelson123/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   └── main.tf
        │   └── web-server/
        │       └── main.tf
        └── submission.md
```