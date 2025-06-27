# Day 21 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [27-06-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Read Chapter 10 of "Terraform: Up & Running"
- [X] Completed Required Hands-on Labs
- [X] Single Server Deployment using Terraform Cloud with sentinel policies
- [ ] lab25- Created reusable Terraform modules for public subnets and applied on tf cloud and actvated cost estimation 
- [X] Created Infrastructure Diagrams

## Infrastructure Details
Lab 24: Single Server Deployment using Terraform Cloud

- **Region:** eu-north-1  
- **Availability Zone:** eu-north-1a  
- **Instance Type:** t3.micro  
- **AMI ID:** ami-00c8ac9147e19828e  

---

####  Key Infrastructure Deployed

- **VPC**
  - CIDR block: `10.0.0.0/16`

- **Subnet**
  - CIDR block: `10.0.1.0/24`
  - Availability Zone: `eu-north-1a`

- **Internet Gateway**
  - Enables outbound internet access.

- **Route Table**
  - Route: `0.0.0.0/0 → Internet Gateway`
  - Associated with the subnet.

- **Security Group**
  - Ingress Rule: Allow SSH (`tcp/22`) from `0.0.0.0/0`
  - Egress Rule: Allow all outbound traffic

- **EC2 Instance**
  - Name: `lab23`
  - AMI: `ami-00c8ac9147e19828e`
  - Type: `t3.micro`
  - Public IP enabled

### lab25
 - Created reusable Terraform modules for public subnets (`public_subnet_a` and `public_subnet_b`)
- Deployed a VPC with CIDR block input from `.tfvars`
- Created and attached two public subnets in separate AZs for load balancer redundancy
- Deployed an Application Load Balancer (ALB) across both public subnets
- Provisioned a Bastion Host in one of the public subnets for SSH access
- Launched Auto Scaling Group (ASG) instances in private subnets behind the ALB
- Defined all variables in `.tfvars`, avoiding any hardcoded infrastructure parameters
- Validated modules and resources using `terraform init`, `validate`, and corrected path/module errors
- Ensured the ALB routes traffic to the ASG instances and passes health checks
- Established secure access via SSH keypair to Bastion Host for EC2 instance debugging

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7344376288998039554/ ]

## Notes and Observations
[Terraform Cloud reads variables from the **Variables tab**, not local `*.tfvars` files unless manually configured.
- When entering variables in TFC:
  - Use `Number` type for integers, **do not quote**.
  - Use `Boolean` for true/false flags, not `"true"` as strings.
  - Use `HCL` type for maps like tags, not text or strings.
- **Cost estimation is done automatically** after the Plan step if enabled in workspace settings and supported by provider (AWS in this case).
- Ensured modules are in correct directory (`modules/`) and symlinked correctly for Terraform Cloud to detect.
- Variable validation is stricter in Terraform Cloud than CLI — great for production readiness.
]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Reading: [1/2 hours]
- Infrastructure Deployment: [1/2 hours]
- Diagram Creation: [20 mins]
- Blog Writing: [10 mins]
- Total: [1 hour]

## Repository Structure
```
Day21/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── 
        │   └── 
        ─lab 24
           ├──main.tf
           ├──terraform.tfvars
           ├──varaiables.tf
        lab 25/
        ├── examples/
                ├──.terraform/
            │ │ └── modules/
            │ │ │ ├── modules.json
            │ │ └── providers/
            │ │ │ ├── LICENSE.txt
            │ │ │ └── terraform-provider-aws_v5.100.0_x5.exe
                ├──.terraform.lock.hcl
        │       ├── main.tf
        │       ├── variables.tf
        │       ├── outputs.tf
                ├── terraform.tfvars
        ├── modules/
        │   ├── vpc/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        │   ├── alb/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        │   ├── asg/
        │   │   ├── main.tf
        │   │   ├── variables.tf
        │   │   ├── outputs.tf
        └──  daily update.md
        └── submission.md
    ├──README.md
    ├──submission_template.md
├──README.md
├──tasks.md
``` 



