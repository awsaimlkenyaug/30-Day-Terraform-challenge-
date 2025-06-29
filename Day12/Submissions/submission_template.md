
# Day 12 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-26
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 5 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment (Blue)
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** EC2 instance tagged 'Blue', part of Target Group Blue. Deployed in public subnet in us-east-1a.

### Web Server Deployment (Green)
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** EC2 instance tagged 'Green', part of Target Group Green. Deployed in public subnet in us-east-1b.

### Application Load Balancer
- **Type:** Application (Layer 7)
- **Availability Zones:** us-east-1a, us-east-1b (two subnets)
- **Behavior:** Routes traffic to either Blue or Green target group based on the `active_color` variable.
- **Routing:** Seamless switch without downtime by modifying one variable.

## Infrastructure Diagrams
Please place your infrastructure diagrams in the architecture folder with the following files:
- `blue-green-lb-diagram.png` - Full blue/green deployment architecture with ALB

## Blog Post
- **Title:** Mastering Zero-Downtime Deployments with Terraform
- **Link:** [https://www.linkedin.com/posts/nelson-ngumo-869033162_terraform-devops-aws-activity-7343939505562779648-SvRp?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAACbNrBEBpmqmiEP6hVsk2sv4gd_ZU_n3IzM]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://www.linkedin.com/posts/nelson-ngumo-869033162_terraform-devops-aws-activity-7343939505562779648-SvRp?utm_source=social_share_send&utm_medium=member_desktop_web&rcm=ACoAACbNrBEBpmqmiEP6hVsk2sv4gd_ZU_n3IzM]

## Notes and Observations
This was the most exciting task yet! I implemented a real-world zero-downtime strategy using Blue/Green deployment and AWS ALB. The task reinforced concepts around high availability, multi-AZ deployment, target groups, and health checks. I also created an Internet Gateway, proper route tables, and fully automated switching logic.

## Additional Resources Used
- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [AWS ALB Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- Hands-on Labs 13 & 14

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 30 minutes
- Blog Writing: 45 minutes
- Total: 4.25 hours

## Repository Structure
Day12/
└── Submissions/
    └── ngumonelson123/
        ├── architecture/
        │   └── blue-green-lb-diagram.png
        ├── terraform/
        │   └── blue-green-alb/
        │       ├── main.tf
        │       ├── variables.tf
        │       └── outputs.tf
        └── submission.md