# Day 21 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [27-06-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Read Chapter 10 of "Terraform: Up & Running"
- [X] Completed Required Hands-on Labs
- [X] Lab265- Created reusable Terraform modules for public subnets and applied on tf cloud and actvated cost estimatio
- [ ] lab26- Created reusable Terraform modules for public subnets and applied on tf cloud and actvated cost estimation added best security practices 
- [X] Created Infrastructure Diagrams

## Infrastructure Details

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

lab 26 added sentimnel policies\
Created reusable Terraform modules for public subnets (`public_subnet_a` and `public_subnet_b`)
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
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7344426335806640129/ ]

## Notes and Observations
[1. **Version control is essential** in infrastructure teams — using branches mirrors real-world collaboration workflows.
2. **Terraform Cloud workspaces** help isolate environments and workflows, aligning with CI/CD pipelines.
3. **Inline security decisions** (like CIDR restrictions) make your Terraform code auditable and maintainable.
4. **Sentinel policies**, even when not enforced, represent a best-practice mindset for compliance and cost governance.
5. **Security in IaC is proactive** — build it into your design with validations, roles, resource tagging, and modularity.
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
Day22/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── lab25.draw.io
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
        lab 26/
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



