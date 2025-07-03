# Day 27 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-07-01
- **GitHub Username:** Ngumonelson123

## Task Completion
- [x] Read Chapter on High Availability & Terraform Modules
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t3.micro
- **Key Features:** Deployed via Terraform with module structure, remote state on S3, state lock on DynamoDB

### Web Server Deployment
- **Region:** us-west-2
- **Instance Type:** t3.micro (Auto Scaling Group)
- **Key Features:** 
  - Load-balanced using ALB
  - Deployed in public subnets
  - Target group tied to private EC2 instances

### Database Tier
- **Primary Region:** us-east-1
- **Read Replica Region:** us-west-2
- **Engine:** Amazon RDS (PostgreSQL)
- **Key Features:** Cross-region replication, Multi-AZ deployment

## Infrastructure Diagrams
- `architecture/single-server.png` ✅
- `architecture/web-server.png` ✅
- `architecture/day27-multi-region.png` ✅ *(custom HA architecture)*

## Blog Post
- **Title:** Building a Multi-Region HA 3-Tier Architecture with Terraform
- **Link:** [https://medium.com/@ngumonelson123/day-27-multi-region-terraform](https://medium.com/@ngumonelson123/day-27-multi-region-terraform) *(Replace with actual link if publishing)*

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://www.linkedin.com/in/nelson-ngumo](https://www.linkedin.com/in/nelson-ngumo) *(Include the specific Day 27 post link)*

## Notes and Observations
- Learned how to deploy highly available systems across AWS regions
- Refactored infrastructure into clean reusable Terraform modules
- Setting up cross-region RDS read replica was the most challenging due to dependency management
- Route53 health checks + failover routing was a game-changer

## Additional Resources Used
- AWS Docs: [Multi-AZ and Read Replica](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html)
- Terraform Registry modules
- YouTube – AWS Architecture Best Practices

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2.5 hours
- Diagram Creation: 1 hour
- Blog Writing: 1.5 hours
- **Total:** 6 hours

## Repository Structure
Day27/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ ├── single-server.png
│ ├── web-server.png
│ └── day27-multi-region.png
├── terraform/
│ ├── vpc/
│ ├── ec2/
│ ├── rds/
│ ├── alb/
│ └── route53/
└── submission.md