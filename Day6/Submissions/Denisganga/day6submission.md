# Day 6 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** 2/06/2025
- **GitHub Username:** Denisganga

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs: Lab 07 (Output Values), Lab 08 (State Management)
- [x] Deployed AWS S3 Bucket Infrastructure
- [x] Configured Remote State with S3 and DynamoDB Locking
- [x] Created Infrastructure Diagrams (tereffarm graph)

## Infrastructure Details

### AWS S3 Bucket Deployment
- **Region:** us-east-1
- **Bucket Name:** terraform-bucket-denis-c2780dc2
- **ACL:** Private (managed via `aws_s3_bucket_acl` resource)
- **Remote State:** Stored in S3 bucket with DynamoDB table for locking

## Infrastructure Files
Your Terraform configuration files included:
- `main.tf`
- `backend.tf`
- `outputs.tf`
- `terraform.tfstate`
- `terraform.tfstate.backup`

## Infrastructure Diagrams

You can generate Terraform resource dependency diagrams using the Terraform `graph` command combined with Graphviz.

To generate the diagram, I have runned the following commands in my terminal:

```bash
terraform graph > graph.dot
dot -Tpng graph.dot -o graph.png
` folder.)
```
## Blog Post
- **Title:** [Managing Terraform State: Best Practices for DevOps]
- **Link:** [https://medium.com/@denisnganga16/managing-terraform-state-best-practices-for-devops-61da10d801d4]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
During this task, I learned how to deploy an AWS S3 bucket using Terraform and how to manage remote state by configuring an S3 backend with DynamoDB for state locking. I faced challenges with permission errors on DynamoDB, which I resolved by updating the IAM user policies to allow necessary DynamoDB actions. The deprecated ACL parameter required me to use the separate `aws_s3_bucket_acl` resource for bucket access control.

## Additional Resources Used
- Terraform official documentation on AWS provider and backend configuration
- AWS IAM documentation for policy management
- [Terraform: Up & Running](https://www.terraformupandrunning.com/)

## Time Spent
- Reading: 2 hours
- Infrastructure Deployment: 2 hours
- Troubleshooting and Debugging: 1 hour
- Blog Writing: 1 hour
- Total: 6 hours

## Repository Structure
Day6/
└── Submissions/
└── Denisganga/
├── backend.tf
├── main.tf
├── outputs.tf
├── terraform.tfstate
└── terraform.tfstate.backup