# Day 19 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-29
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Connected GitHub Repo to Terraform Cloud
- [x] Set up a new Terraform Cloud Workspace (`day19-single-server`)
- [x] Added environment variables for AWS credentials
- [x] Wrote a production-ready `main.tf` to deploy an EC2 instance
- [x] Successfully triggered a plan and applied via Terraform Cloud
- [x] Dynamically retrieved latest AMI using `aws_ami`
- [x] Wrote blog and shared insights on gradual IaC adoption
- [x] Destroyed infrastructure using Terraform Cloud

## Infrastructure Details

### EC2 Instance Deployment
- **Provider:** AWS
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **AMI:** Dynamically fetched latest Amazon Linux 2 AMI
- **Tags:** Name = Day19Server

## Diagram
- See attached: `day19_iac_architecture.png`

## Blog & LinkedIn
- **Blog Post:** "Day 19 of Terraform Challenge – Adopting Infrastructure as Code with Terraform Cloud"
- **LinkedIn Highlight:** Celebrated successful IaC deployment with real-time AWS provisioning from VCS push.

---

✅ Challenge Completed Successfully!
