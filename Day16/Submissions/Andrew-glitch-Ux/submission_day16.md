# Day 16 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [21/6/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 8 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [X] Multi-Cloud Kubernetes Setu
- [X] High-Availability Hello-World App Deployment with Terraform Modules
- [X] Created Infrastructure Diagrams

## Infrastructure Details

### Multi-Cloud Kubernetes Setup
Initialized a multi-cloud project structure (AWS + GCP)
Configured multiple Terraform providers (aws, google, kubernetes)
Prepared EKS deployment for Docker container workloads
Isolated cloud logic into separate Terraform files
Injected all cloud variables via .tfvars for flexibility

## High-Availability Hello-World App Deployment with Terraform Modules

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
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7341916734146154500/ ]

## Notes and Observations
[ 
1. Reusing modules to avoid duplicated logic.
2. Calling modules with different inputs for different resources.
3. Structuring Terraform code for scale and production-readiness.
4. Terraform folder structure and module resolution.
5. Isolating infrastructure definitions from deployment configurations.
]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Reading: [1 hours]
- Infrastructure Deployment: [2 hours]
- Diagram Creation: [1/2 hours]
- Blog Writing: [1/4 hours]
- Total: [ 3hours 45 mins]

## Repository Structure
```
Day16/
└── Submissions/
└── Andrew-glitch-Ux/
├── Architecture/
│ ├── lab17drawio.png
│ └── lab18.drawio
── lab17/
│ ├── .terraform/
│ │ ├── AWS/
│ │ │ └── modules.json
│ │ ├── google/
      ├── 6.39.0 
│ │ │  ├── LICENSE.txt
│ │ │  └── terraform-provider-aws_v5.100.0_x5.exe
│ ├── .terraform.lock.hcl
│ ├── main.tf
│ ├── outputs.tf
│ ├──providers.tf
  ├──terraform.tfstate
  ├──terraform.tfstate.backup
│ ├── terraform.tfvars
│ └── variables.tf
├── daily update.md
── lab18/
      ├──examples
        │ ├── .terraform/
        │ │ └── modules/
        │ │ │ ├── modules.json
        │ │ │ └── providers/
        │ │ │ ├── LICENSE.txt
        │ │ │ └── terraform-provider-aws_v5.100.0_x5.exe
          ├──.terraform.lock.hcl
          ├── main.tf
    │ │   ├── outputs.tf
          ├── README.md
          ├── terraform.tfstate
          ├── terraform.tfvars
          ├── variables.tf
    └── modules/
    │ ├── alb/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    │ ├── asg-rolling-deploy/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    ├──   bastion-host/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    ├──   private-subnet/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    ├──   subnet/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    ├──   vpc/
    │ │ ├── main.tf
    │ │ ├── outputs.tf
    │ │ └── variables.tf
    ── test\hello-world-app/
    │ ├── main_test.go/
    ├── daily update.md
    ├── submission day 16.md
    └── README.md
    ├── submission_template.md
    └── tasks.md
```
