# Day 5 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** 1/06/2025
- **GitHub Username:** Denisganga

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server with Auto Scaling and Load Balancer
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**  
  - Single EC2 instance running in a custom VPC  
  - Basic security group allowing SSH and HTTP traffic  

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**  
  - VPC with two public subnets in different availability zones  
  - Internet Gateway attached to VPC for internet access  
  - Application Load Balancer (ALB) configured for HTTP on port 80  
  - Target Group linked to ALB health checks  
  - Auto Scaling Group (ASG) using Launch Template for EC2 instances  
  - Security Groups for ALB and EC2 instances allowing HTTP traffic  
  - Auto Scaling configured with desired, min, and max capacity parameters  

## Infrastructure Diagrams

For the infrastructure diagrams, you can use tools like Draw.io or Lucidchart to create clean AWS architecture diagrams with official AWS icons. Alternatively, Terraform’s graph can be generated using:

```bash
terraform graph > graph.dot
dot -Tpng graph.dot -o graph.png
```
## Blog Post

    Title: Managing High Traffic Applications with AWS Elastic Load Balancer and Terraform

    Link: https://medium.com/@denisnganga16/managing-high-traffic-applications-with-aws-elastic-load-balancer-and-terraform-40fc0bb58030

## Social Media

    Platform: [LinkedIn]

    Post Link: https://www.linkedin.com/posts/denis-nganga16_30daytfchallenge-hug-hashicorp-activity-7334712746753552384-f6OZ?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD6f18kBkqYbwrS6aVUAbqFNTkKbSj8rzzk

## Notes and Observations

    Learned how to create and manage infrastructure with Terraform using AWS provider

    Implemented VPC, subnets, security groups, and Internet Gateway for public access

    Created launch templates and auto scaling groups to automatically manage web server capacity

    Configured an Application Load Balancer with target groups and listeners

    Understood Terraform state and how it tracks resource changes

    Faced and resolved issues related to subnet, internet gateway, and AMI availability

    Learned how to generate Terraform infrastructure graphs with Graphviz

Additional Resources Used

    Terraform official documentation

    AWS documentation on VPC and Load Balancers

    "Terraform: Up & Running" by Yevgeniy Brikman

    Graphviz official website

## Time Spent

    Reading: 2 hours

    Infrastructure Deployment: 3 hours

    Diagram Creation:  2 minutes

    Blog Writing: 1 hour

    Total: 6 hours

## Repository Structure

30-Day-Terraform-challenge-/Day5/Submissions/Denisganga/
├── aws/
├── awscliv2.zip
├── day5submission.md
├── graph.dot
├── graph.png
├── main.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
├── variables.tf
