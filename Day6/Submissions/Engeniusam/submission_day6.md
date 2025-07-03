Day 5 Submission

## Personal Information
- **Name:** Samuel Macharia
- **Date:** 4th June 2025 17:23 PM
- **GitHub Username:** Engeniusam

## Task Completion
- [✔] Complete Chapter 2 and start Chapter 3 how to manage Terraform state.
- [✔] Completed Required Hands-on Labs
- [✔] Use Terraform to scale your web server cluster to handle increased load.
- [✔] Understand the concept of state. what happens when you manully update the state file.
## Infrastructure Details
#### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  The concept of security groups with egress and ingress rules allowing and denying traffic in certain ports.


## Blog Post
- **Title:** Managing Terraform State: Best Practices for DevOps
- **Link:**

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/engeniusam/status/1930169897155170483

## Notes and Observations
- Managing state locally can be solved by remote state managed but this creates a chicken-egg problem where the backend has to be created manually first(e.g S3, Dynamodb) for the state to be stored.

## Additional Resources Used
developer.hashicorp.com - Official documentation
"Terraform: Up & Running" by Yevgeniy Brikman

## Time Spent
- Reading: 1 hour
- Lab implementation: 2.5 hour
- Infrastructure Deployment: 1 hour
- Total: 4.5 hours

```
Day6/
└── Submissions/
    └── Engeniusam/
        └── Output_values_lab/
            ├── .terraform/                <-- Should be ignored by Git
            ├── modules/
            ├── .gitignore
            ├── .terraform.lock.hcl        <-- Optional to commit
            ├── main.tf
            ├── terraform.tf
            ├── terraform.tfstate          <-- Should be ignored by Git
            ├── terraform.tfstate.backup   <-- Should be ignored by Git
            ├── variables.tf
            └── submission_day6.md
```