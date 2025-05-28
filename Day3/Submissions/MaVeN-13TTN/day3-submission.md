# Day 3 Submission

## Personal Information
- **Name:** Ndungu Kinyanjui
- **Date:** May 28, 2025
- **GitHub Username:** MaVeN-13TTN

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t3.micro
- **Key Features:** 
  - Amazon Linux 2 AMI (ami-09f4814ae750baed6)
  - SSH access only (port 22)
  - Encrypted EBS volume (8GB gp3)
  - Default VPC deployment (vpc-029471017da44bfc8)
  - Public subnet (subnet-07d5c4df1d0ef85be)
  - Security group with SSH access
  - IMDSv2 enabled for enhanced security

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t3.micro
- **Key Features:**
  - Amazon Linux 2 AMI (ami-09f4814ae750baed6)
  - Apache HTTP Server installed via user data script
  - HTTP (port 80) and SSH (port 22) access
  - User data script for automated Apache installation
  - Custom HTML landing page with server information
  - Encrypted EBS volume (8GB gp3)
  - Default VPC deployment (vpc-029471017da44bfc8)
  - Public subnet (subnet-07d5c4df1d0ef85be)
  - IMDSv2 enabled for enhanced security

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

**Additional Files Created:**
- `complete-infrastructure.png` - Complete overview of both deployments
- Architecture diagrams created using Python `diagrams` library (Diagrams as Code)
- Python scripts available in `architecture/diagrams/` folder

## Blog Post
- **Title:** Day 3 Technical Documentation: Deploying Basic Infrastructure with Terraform
- **Link:** Day3/technical-documentation.md

## Social Media
- **Platform:** Twitter/X
- **Post Link:** https://x.com/Maven_TTN/status/1927757523928388082

## Notes and Observations
During Day 3, I successfully learned about Terraform providers, resource blocks, and data sources through hands-on implementation. Key learnings include:

1. **Provider Configuration**: Learned how to configure AWS provider with version constraints and default tags
2. **Resource Blocks**: Successfully created EC2 instances, security groups, and key pairs
3. **Data Sources**: Used data sources to query existing AWS resources (VPC, subnets, AMIs)
4. **User Data Scripts**: Implemented automated Apache installation and configuration
5. **Infrastructure as Code**: Both infrastructure and diagrams created as code for maintainability

**Challenges Faced:**
- Initial SSH key configuration required proper file permissions
- User data script needed time to complete Apache installation
- Diagrams library required specific import adjustments for available components

**Key Achievements:**
- Two working Terraform deployments with different purposes
- Automated web server setup with custom landing page
- Architecture diagrams generated as code using Python
- Proper security group configurations for different access patterns

## Additional Resources Used
- AWS CLI Documentation
- HashiCorp Terraform AWS Provider Documentation
- Python Diagrams Library Documentation
- Amazon Linux 2 User Guide for Apache configuration

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 1 hour
- Blog Writing: 1.5 hours
- Total: 5.5 hours

## Repository Structure
```
Day3/
└── Submissions/
    └── MaVeN-13TTN/
        ├── architecture/
        │   ├── diagrams/
        │   │   ├── single_server_diagram.py
        │   │   ├── web_server_diagram.py
        │   │   └── complete_infrastructure.py
        │   ├── single-server.png
        │   ├── web-server.png
        │   ├── complete-infrastructure.png
        │   └── diagram-validation-report.md
        ├── terraform/
        │   ├── single-server/
        │   │   └── main.tf
        │   └── web-server/
        │       └── main.tf
        ├── day3-submission.md
        └── technical-documentation.md
```
