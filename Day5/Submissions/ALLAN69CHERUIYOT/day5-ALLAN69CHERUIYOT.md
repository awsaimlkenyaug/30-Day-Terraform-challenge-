# Day 5 Submission

## Personal Information
- **Name:** ALLAN CHERUIYOT
- **Date:** 6/5/2025
- **GitHub Username:** ALLAN69CHERUIYOT

## Task Completion
[✔️] Read Chapter 2 and started Chapter 3 of "Terraform: Up & Running" (Sections on Load Balancers and Terraform State)
[✔️] Completed Required Hands-on Labs (Understanding State, Output Values)
[✔️] Scaled web server cluster using Terraform (Deployed AWS Elastic Load Balancer)
[✔️] Understood Terraform state files and management concepts
[✔️] Created Infrastructure Diagrams for the scaled web application

## Infrastructure Details

### Scaled Web Application Deployment (with Load Balancer)
- **Region:** us-east-1
- **Instance Type:**  t2.micro (for backend web servers)
- **Key Features:** Deployed an AWS Application Load Balancer (ALB) to distribute incoming web traffic.
Configured an ALB Target Group to register and manage the health of backend web server instances (your clustered servers from Day 4).
Created an ALB Listener to receive HTTP traffic on port 80 and forward it to the target group.
Integrated existing clustered EC2 instances with the new Target Group.
Utilized specific Security Groups for the ALB (allowing inbound HTTP/HTTPS) and for the EC2 instances (allowing inbound traffic only from the ALB's security group and SSH).
This setup significantly enhances the high availability and scalability of the web application.



## Infrastructure Diagrams
Please place your infrastructure diagrams in the architecture folder with the following files:

scaled-web-app.png - Diagram for the scaled web application deployment (showing ELB, target group, and instances)

## Blog Post
- **Title:** Managing High Traffic Applications with AWS Elastic Load Balancer and Terraform
- **Link:** https://allan-blog.hashnode.dev/managing-high-traffic-applications-with-aws-elastic-load-balancer-and-terraform

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/posts/allan-cheruiyot-730896331_30daytfchallenge-hug-hashicorp-activity-7336374089244106752-UbO6?utm_source=share&utm_medium=member_desktop&rcm=ACoAAFOaNZQBPsFm1zkiP9oxzdKTVE9IbqnDYZU

## Notes and Observations
Day 5 was pivotal in understanding how to build truly robust and scalable web applications with Terraform. Deploying the Elastic Load Balancer was a significant step, as it's the primary component for distributing traffic and enabling high availability beyond just having multiple instances. Understanding the lifecycle of the ELB, listeners, and target groups was key.

The deep dive into Terraform state was equally critical. It hammered home the importance of the terraform.tfstate file as the source of truth and the severe implications of manually altering it. Recognizing how terraform plan identifies "drift" was a valuable insight into maintaining infrastructure integrity. Challenges primarily involved correctly wiring up the ELB, target group, and instance security groups to ensure traffic flowed correctly while maintaining appropriate access control.

## Additional Resources Used
Terraform Documentation: AWS Load Balancer
Terraform Documentation: AWS Load Balancer Target Group
Terraform Documentation: Managing Terraform State
AWS Documentation on Application Load Balancers

## Time Spent
- Reading: 2 hours
- Infrastructure Deployment: 1 hours
- Diagram Creation: 1 hours
- Blog Writing: 30 minutes
- Total: 4.5 hours

## Repository Structure
```
Day5/
└── Submissions/
    └── ALLAN69CHERUIYOT/
        ├── architecture/
        │   ├── scaled-web-app.png
        │   
        ├── terraform/
        │   ├── scaled-web-app/
        │   │   ├── main.tf
        │  
        └── day5-ALLAN69CHERUIYOT.md
``` 



