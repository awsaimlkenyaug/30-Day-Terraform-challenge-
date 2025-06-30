# Day 25 Submission

## Personal Information
- **Name:** [Andrew-glitch-Ux]
- **Date:** [30-06-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Scalable Web Application Architecture
- [x] Completed Required Hands-on Labs
- [X] Version Control Workflow
- [X] Created Infrastructure Diagrams

## Infrastructure Details
### Scalable Web Application Deployment with Load Balancing and Auto Scaling

Infrastructure Components

### 1. **VPC Module**
- Custom Terraform module created to define the network foundation:
  - VPC with CIDR block `10.0.0.0/16`
  - Two public subnets (`10.0.1.0/24`, `10.0.2.0/24`) across separate AZs
  - Internet Gateway
  - Public Route Table and subnet associations
- Output: `vpc_id`, `public_subnet_ids`, `igw_id`, `route_table_id`

### 2. **Security Group**
- A standalone security group (defined in the `dev` environment, not a module)
  - Allows HTTP (port 80) traffic from anywhere
  - Attached to the EC2 instance via a variable (`vpc_security_group_ids`)

### 3. **EC2 Instance**
- Web server deployed in one of the public subnets
- Uses latest Amazon Linux 2 AMI (customizable)
- Automatically associates public IP
- Connected to the VPC and security group

### 4. **Application Load Balancer (ALB)**
- ALB is internet-facing and listens on port 80
- Distributes traffic to EC2 targets
- Registered with Target Group linked to ASG

### 5. **Auto Scaling Group (ASG)**
- Manages EC2 instances across both public subnets
- Based on Launch Template
- Configured for minimum and maximum instance scaling
- Health checks via ALB
- Scaling policies can be added using CloudWatch alarms (bonus)



## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7345456633608552448/ ]

## Notes and Observations
[Multi-Subnet VPC Module**
   - Successfully built and debugged a reusable VPC module supporting two public subnets, internet gateway, route table, and associations.
   - Learned to correctly define and reference outputs like `public_subnet_ids` for downstream modules (e.g., ASG, EC2).

2. **Fixed Terraform Validation Issues**
   - Resolved multiple validation errors caused by incorrect or missing output references (e.g., `public_subnet_id` vs `public_subnet_ids`).
   - Understood why Terraform requires precise output names and unique declarations within `outputs.tf`.

3. **Security Group Integration**
   - Created a security group directly in the environment (not in a module), and linked it to the EC2 instance using a variable.
   - Observed how Terraform prompts for values like `security_group_id` when a value isn't explicitly wired in the code.

4. **Handled Real AWS Errors**
   - Investigated and resolved a real AWS API error (`InvalidSubnet.Conflict`) when overlapping CIDR blocks were used.
   - Learned the importance of proper CIDR planning across multiple subnets to avoid provisioning failures.

5. **Version Control Workflow**
   - Committed all finalized code from Day 26 and pushed to a new branch `week5` to continue work cleanly.
   - Reinforced best practices around working with Git branches, avoiding data loss, and preparing for future merges.]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Infrastructure Deployment: [2 hours]
- Diagram Creation: [1/2 Hours]
- Blog Writing: [1/2 hours]
- Total: [3 hours]

## Repository Structure
```
Day25/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── day 26.drawio.png
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




