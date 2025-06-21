# Day 10 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [6/06/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 5 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [X] Deployed IAM Users and Subnets using Modules
- [x] Configured Remote Backend with S3 and DynamoDB for State Management
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### 
- **Region:** eu-north-1 (conditional via variable)
- **Instance Type:** N/A (no EC2 resources in this lab)
- **Key Features:**  
  - Deployed IAM Users using reusable module  
  - IAM users dynamically provisioned with `for_each`  
  - Output of IAM user ARNs

### 
- **Region:** eu-north-1 (conditional)
- **Instance Type:** N/A
- **Key Features:**  
  - Provisioned 2 public subnets in different AZs  
  - Subnet config via map variable and `for_each`  
  - Used reusable module with `extra_tags` support  
  - VPC ID was passed from root module (assumed existing)

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `iam-users.png` – Diagram for IAM user creation module
- `network-module.png` – Diagram for network (subnet) module

## Blog Post
- **Title:** [The More I Broke It, The Better I Understood It: My Terraform Breakthroughs]
- **Link:** [https://dev.to/andre_a/the-more-i-broke-it-the-better-i-understood-it-my-terraform-breakthroughs-4ej7 ]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7337280443014070273/ ]

## Notes and Observations
- Learned how to avoid hardcoding by replacing inline values with variables.
- Explored dynamic provisioning using `for_each` with maps and lists.
- Practiced modular infrastructure using two separate modules: IAM and Network.
- Used conditional logic to control AWS region selection via variable.
- Integrated `terraform.tfvars` to simplify configuration management.

## Additional Resources Used
- Terraform Docs: [https://developer.hashicorp.com/terraform/language](https://developer.hashicorp.com/terraform/language)
- "Terraform Up & Running" – Chapter 5 (Loops & Gotchas)
- Draw.io AWS Icon Set for Infra Diagrams

## Time Spent
- Reading: 1.5 hours
- Infrastructure Deployment: 2 hours
- Diagram Creation: 45 minutes
- Blog Writing: [X hours]
- Total: ~4 hours

## Repository Structure
```
Day10/
└── Submissions/
    └── Andrew-glitch-Ux/
        ├── architecture/
        │   ├── lab11.drawio.png
        │   └── lab12.drawio.png
        ├── lab11/
        │   ├── envs/
        │   │   ├── dev/
        │   │   │   └── terraform/
        │   │   │       ├── modules/
        │   │   │       ├── module.json
        │   │   │       ├── providers/
        │   │   │       │   ├── LICENSE.txt
        │   │   │       │   └── terraform-provider-aws_v5.99.1_x5.exe
        │   │   │       ├── .terraform.lock.hcl
        │   │   │       ├── main.tf
        │   │   │       ├── outputs.tf
        │   │   │       ├── terraform.tfstate
        │   │   │       ├── terraform.tfstate.backup
        │   │   │       ├── terraform.tfvars
        │   │   │       └── variables.tf
        │   │   ├── prod/
        │   │   │   └── terraform/
        │   │   │       └── [same structure as dev]
        │   │   └── staging/
        │   │       └── terraform/
        │   │           └── [same structure as dev]
        │   └── modules/
        │       └── web-server/
        │           ├── main.tf
        │           ├── outputs.tf
        │           └── variables.tf
        ├── LAB12/
        │   ├── .terraform/
        │   ├── modules/
        │   │   ├── iam-user/
        │   │   │   ├── main.tf
        │   │   │   ├── outputs.tf
        │   │   │   └── variables.tf
        │   │   ├── network/
        │   │   │   ├── main.tf
        │   │   │   ├── outputs.tf
        │   │   │   └── variables.tf
        │   │   └── vpc/
        │   │       ├── main.tf
        │   │       ├── outputs.tf
        │   │       └── variables.tf
        │   ├── providers/
        │   │   ├── LICENSE.txt
        │   │   └── terraform-provider-aws_v5.99.1_x5.exe
        │   ├── .terraform.lock.hcl
        │   ├── main.tf
        │   ├── outputs.tf
        │   ├── terraform.tfstate
        │   ├── terraform.tfvars
        │   ├── variables.tf
        │   └── vpc.tf
        ├── daily-update.md
        ├── submission_day10.md
        ├── submission_template.md
        ├── README.md
        └── tasks.md
README.md
tasks.md

``` 



