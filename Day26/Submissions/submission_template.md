Day 26 Submission
Personal Information
Name: Nelson Ngumo

Date: 2025-06-29

GitHub Username: ngumonelson123

Task Completion
 Read Chapter 2 of "Terraform: Up & Running"

 Completed Required Hands-on Labs

 Deployed Single Server

 Deployed Web Server

 Created Infrastructure Diagrams

Infrastructure Details
Single Server Deployment
Region: us-east-1

Instance Type: t2.micro

Key Features:

Security group with HTTP (80) and SSH (22) access

Remote state stored in S3 with locking via DynamoDB

Tagged for environment and automation

Web Server Deployment
Region: us-east-1

Instance Type: t2.micro (via Launch Template)

Key Features:

Load Balanced with AWS ELB

Auto Scaling Group with min/max/desired instances

CloudWatch alarms to scale based on CPU utilization

Modular structure for EC2, ELB, and ASG

Infrastructure Diagrams
single-server.png ✅

web-server.png ✅

Blog Post
Title: Building a Scalable Web App with Terraform, ELB & Auto Scaling

Link: https://medium.com/@ngumonelson123/day26-scalable-terraform-iac

Social Media
Platform: LinkedIn

Post Link: https://www.linkedin.com/posts/ngumonelson123_day26-terraform-scalable-iac-activity-

Notes and Observations
Modularization made it easier to manage complex infrastructure.

Faced challenges in linking Launch Template with ASG; resolved via dependency outputs.

Learned how CloudWatch alarms enhance elasticity with autoscaling triggers.

Additional Resources Used
Terraform Registry Modules

AWS Auto Scaling & ELB Documentation

YouTube: Terraform Auto Scaling with ELB by FreeCodeCamp

Time Spent
Reading: 1.5 hours

Infrastructure Deployment: 3 hours

Diagram Creation: 1 hour

Blog Writing: 1 hour

Total: 6.5 hours

Repository Structure
Day26/
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
