# Day 25 Submission

## Personal Information
- **Name:** [Andrew-glitch-Ux]
- **Date:** [01-07-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Read tf documentation
- [x] Completed Required Hands-on Labs
- [X] Full-Stack Infrastructure Deployment with Networking, DNS, and State Management
- [X] Created Infrastructure Diagrams

## Infrastructure Details
## Full-Stack Infrastructure Deployment with Networking, DNS, and State Management

### Infrastructure Components Overview

This deployment includes a modular, production-grade setup of core AWS resources, provisioned using Terraform and organized for reusability, scalability, and stateful automation.

---

### 1. **VPC & Networking**
- Custom VPC with CIDR `10.0.0.0/16`
- Public Subnet in `eu-north-1a` with CIDR `10.0.1.0/24`
- Internet Gateway and Route Table with public routing (`0.0.0.0/0`)
- Subnet associated with the Route Table

**Outputs:** `vpc_id`, `subnet_id`, `igw_id`, `route_table_id`

---

### 2. **Security Groups**
- One standalone security group defined per environment:
  - Allows HTTP (port 80) and SSH (port 22) from anywhere (adjustable)
- Used by both EC2 and ALB via variable `vpc_security_group_ids`

---

### 3. **EC2 Instance**
- Deployed in public subnet with public IP
- Amazon Linux 2 AMI (passed via variable)
- Uses user data for server bootstrap (e.g., install web server)
- Tagged and managed through environment-specific variables

---

### 4. **Application Load Balancer (ALB)**
- Internet-facing ALB with listener on port 80
- Attached to Target Group that forwards traffic to EC2 instances
- ALB DNS output used in Route 53 (`record_value_alb`)

---

### 5. **Auto Scaling Group (ASG)**
- ASG spans public subnet(s)
- Configured with Launch Template (AMI, instance type, SGs)
- Supports zero-downtime scaling with min/max/desired instance count
- Health checks via ALB

---

### 6. **Amazon RDS (MySQL)**
- Private RDS instance in a non-default VPC
- Uses parameterized input for instance size, name, engine, and username
- Not publicly accessible
- Optional snapshot retention and deletion protection

---

### 7. **Route 53 (DNS)**
- Public Hosted Zone (e.g., `example.com`)
- DNS Records created:
  - `app.example.com → ALB` (CNAME or A)
  - `ec2.example.com → EC2` (A record)
- Records dynamically created using outputs from ALB/EC2 modules

---

### 8. **S3 Buckets**
- **Terraform backend state** stored in an encrypted S3 bucket (`use_lockfile = true`)
- **Versioning-enabled source and destination buckets** for S3 replication
- IAM role and policy configured for replication actions

---

### 9. **Terraform Backend (State Management)**
- Remote state configured using `terraform { backend "s3" {} }`
- Locked using DynamoDB table (optional)
- Parameters like `bucket`, `key`, and `region` defined via variables

---

### Tagging & Reusability
- All resources tagged using the `common_tags` variable (project, environment, owner)
- All values passed through variables (`terraform.tfvars`) for full reusability across environments (`dev`, `prod`, etc.)




## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7345826960268324866/ ]

## Notes and Observations
[**Modular Route 53 Integration:**  
   Successfully created reusable Route 53 records for ALB and EC2 by passing dynamic values like `alb_dns_name` and `ec2.public_ip`, reinforcing how DNS integrates with infrastructure outputs.

2. **Understanding A vs CNAME Records:**  
   Learned that `A` records point to IPs (like EC2 public IPs) while `CNAME` records alias domain names (like the ALB DNS). Choosing the right type is critical for proper resolution.

3. **Avoiding Unused Infrastructure (S3 Endpoint):**  
   Recognized that not all buckets serve frontend purposes — S3 used for replication or backend state doesn’t require Route 53 records. Cleaned up the config accordingly.

4. **State Management with S3 Backend:**  
   Set up remote state storage in an encrypted S3 bucket using the `backend "s3"` block, ensuring safer, centralized state tracking with optional lockfile support.

5. **Improved Terraform File Organization:**  
   Reinforced separation of concerns by keeping `main.tf`, `variables.tf`, and `terraform.tfvars` clean and environment-specific, making the codebase more maintainable and scalable.]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Infrastructure Deployment: [2 hours]
- Diagram Creation: [1/2 Hours]
- Blog Writing: [1/2 hours]
- Total: [3 hours]

## Repository Structure
```
Day26/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── day 27.drawio.png
        ├── envs/
            └── dev/
                ├──.terraform/
            │ │ └── modules/
            │ │ │ ├── modules.json
            │ │ └── providers/
            │ │ │ ├── LICENSE.txt
            │ │ │ └── terraform-provider-aws_v5.100.0_x5.exe
                ├──.terraform.lock.hcl
            │   ├── main.tf
                ├── output.tf
                ├── variables.tf
            │   ├── terraform.tfstate
                ├──terraform.tfstate
            │   └── terraform.tfvars
        ├── modules/
        │   ├── asg/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        │   ├── ec2/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        │   ├── elb/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
            ├── rds/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
            ├── route53/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        │   ├── s3_replication/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
            ├── Security group/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
                ├──security_group/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
            ├── vpc/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        ├── backend.tf
        ├── provider.tf
        └── variables.tf
        └──  daily update.md
        └── submission.md
    ├──README.md
    ├──submission_template.md
├──README.md
├──tasks.md
``` 




