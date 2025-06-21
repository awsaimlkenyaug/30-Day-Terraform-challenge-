# Day 11 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [9/06/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 5 of "Terraform: Up & Running"
- [x] Completed Lab 13: Module Composition
- [x] Implemented reusable VPC and Web Server modules
- [x] Used conditional logic for optional resource creation
- [x] Generated Terraform architecture diagrams

## Infrastructure Details

### VPC Deployment
- **Region:** eu-north-1
- **Instance Type:** N/A (VPC-only)
- **Key Features:**  
  - Reusable module to provision VPC  
  - Public subnet with user-defined CIDR  
  - Internet Gateway  
  - Route table and route association  
  - Values fully driven by `terraform.tfvars`

### Web Server Deployment
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:**  
  - Conditional deployment based on `deploy_instance` flag  
  - Custom ingress and egress rules  
  - AMI and instance type configurable  
  - EC2 created in existing subnet (passed as input)  
  - Security group defined by rules in `terraform.tfvars`

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
- This lab helped reinforce how to split infrastructure into clean, reusable modules.
- Writing `terraform.tfvars` to drive all logic made deployments flexible and DRY.
- The `deploy_instance` flag was useful for testing module independence.
- Conditional logic and proper use of `outputs` helped link VPC and web server modules.
- Faced one error about duplicate outputs — resolved by ensuring outputs are only declared in `outputs.tf`, not `variables.tf`.

## Additional Resources Used
- Terraform documentation (for `for_each` and conditional blocks)
- Previous lab module references
- AWS Console (for quick state validation)

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 30 minutes
- Blog Writing: [X hours]
- Total: [3.5 hours]

## Repository Structure
```
Day11/
└── Submissions/
└── Andrew-glitch-Ux/
├── Architecture/
│ ├── lab12.drawio.png
│ └── Lab13.drawio.png
├── lab12/
│ └── live/
│ └── dev/
│ └── terraform/
│ ├── .terraform.lock.hcl
│ ├── main.tf
│ ├── terraform.tfstate
│ ├── terraform.tfvars
│ ├── variables.tf
│ ├── modules/
│ │ └── web-server/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ └── providers/
│ ├── LICENSE.txt
│ └── terraform-provider-aws_v5.99.1_x5.exe
├── lab13/
│ ├── live/
│ │ └── dev/
│ │ ├── .terraform/
│ │ │ ├── modules/
│ │ │ │ └── modules.json
│ │ │ └── providers/
│ │ │ ├── LICENSE.txt
│ │ │ └── terraform-provider-aws_v5.99.1_x5.exe
│ │ ├── .terraform.lock.hcl
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ ├── terraform.tfstate
│ │ ├── terraform.tfstate.backup
│ │ ├── terraform.tfvars
│ │ └── variables.tf
│ └── modules/
│ ├── vpc/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ └── web-server/
│ ├── main.tf
│ ├── outputs.tf
│ └── variables.tf
├── daily update.md
├── submission_Day 11.md
├── README.md
├── submission_template.md
└── tasks.md
```


