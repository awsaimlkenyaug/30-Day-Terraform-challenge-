# Day 3 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** 29/05/2025
- **GitHub Username:** Denisganga

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**  
  - Ubuntu 20.04 AMI used  
  - Security group created allowing SSH (port 22) and HTTP (port 80) inbound access  
  - EC2 instance launched with the security group attached  
  - Random ID resource used to generate unique hex string for resource naming

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**  
  - Same as Single Server Deployment  
  - Added S3 bucket with name suffixed by the random hex ID to ensure global uniqueness  
  - Terraform used to automate resource provisioning and management

## Infrastructure Diagrams
some of screenshots taken
- `Screenshot 2025-05-29 094450.png`
- `security.png` 

## Blog Post
- **Title:** Deploying Your First Server with Terraform: A Beginner’s Guide  
- **Link:** [[ here](https://medium.com/@denisnganga16/deploying-your-first-server-with-terraform-a-beginners-guide-9e6c8638b1f3)]

## Social Media

- **Platform:** LinkedIn
- **Post Link:** [LinkedIn Post](https://www.linkedin.com/posts/denis-nganga16_30daytfchallenge-terraform-iac-activity-7334630571203014656-glVJ?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD6f18kBkqYbwrS6aVUAbqFNTkKbSj8rzzk)

## Notes and Observations
Working with Terraform to deploy an EC2 instance on AWS was a great learning experience. Using the `random_id` resource helped avoid naming conflicts, especially with globally unique resources like S3 buckets. Defining security groups properly ensured secure access to the server. Running `terraform plan` before `apply` gave clear visibility into the changes. Overall, the declarative IaC approach is much more reliable and repeatable than manual setup.
## Challenges Faced
- Initially, I encountered an error referencing an undeclared AWS VPC resource because the resource was not defined in the Terraform configuration. I resolved this by ensuring all required resources, including VPCs, were properly declared or referenced.
- Adding the `random_id` resource caused Terraform to require a new provider (hashicorp/random), which led to an error during planning. Running `terraform init -upgrade` fixed the provider installation issue.
- Understanding how to concatenate the random hex string into the S3 bucket name to ensure global uniqueness required careful reading of Terraform syntax and resource dependencies.
- Managing resource replacements in Terraform when changing the S3 bucket name was a new concept; the forced replacement due to bucket renaming was important to understand
## Additional Resources Used
- Terraform documentation (https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- AWS EC2 and S3 official docs
- "Terraform: Up & Running" by Yevgeniy Brikman, Chapter 2

## Time Spent
- Reading: 1 hour  
- Infrastructure Deployment: 2 hours   
- Blog Writing: 1 hour  
- Total: 4 hours
