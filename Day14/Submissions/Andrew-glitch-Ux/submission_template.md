# Day 14 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [6/17/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 7 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Multi-Region Server DeploymentMulti-Region Server Deployment
- [x] Lab 15 secrets management 
- [x] Created Infrastructure Diagrams

## Infrastructure Details
### Lab 15 secrets management 
- **Region:** eu-north-1
- **Instance Type:** db.t3.micro (RDS MySQL)
- **Key Features:** 
  - Secure GPG-based secrets decryption (`secrets.json.gpg`)
  - Private subnet RDS deployment with custom SG
  - Terraform backend using S3 with encryption
  - DynamoDB used for Terraform state locking
  - No secret exposure in Terraform outputs or logs
### Multi-Region Server DeploymentMulti-Region Server Deployment
- Deployed VPCs in eu-north-1 & eu-west-1
- Launched EC2 instances in both regions
- Used provider aliases for multi-region setup
- Applied Terraform modules with region isolation
- Injected all config via tfvars for flexibility
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
[.learned how to use the same Terraform module for multiple regions using provider aliases and dynamic inputs
learned to avoid hardcoding by injecting values through variables and tfvars
learned the correct use of the providers meta-argument instead of provider inside module blocks
learned the best practice of separating regional deployments to ensure fault isolation
learned how to structure production-grade Terraform projects with proper folder layout, provider logic, variable injection, and module reusability]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Reading: [2 hours]
- Infrastructure Deployment: [20 mins]
- Diagram Creation: [10 mins]
- Blog Writing: [10 mins]
- Total: [2hours 40 mins]

## Repository Structure
```
Day13/
└── Submissions/
└── Andrew-glitch-Ux/
├── Architecture/
│ ├── lab14.drawio.png
│ └── lab15.drawio.png
├── lab15/
│ ├── .terraform/
│ │ ├── modules/
│ │ │ └── modules.json
│ │ ├── providers/
│ │ │ ├── LICENSE.txt
│ │ │ └── terraform-provider-aws_v5.100.0_x5.exe
│ │ └── terraform.tfstate
│ ├── modules/
│ │ ├── db/
│ │ │ ├── main.tf
│ │ │ ├── outputs.tf
│ │ │ └── variables.tf
│ │ └── vpc/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ ├── scripts/
│ │ └── decrypt-secrets.sh
│ ├── secrets/
│ │ ├── secrets.json.gpg
│ │ └── secrets.json (gitignored)
│ ├── .terraform.lock.hcl
│ ├── backend.tf
│ ├── main.tf
│ ├── outputs.tf
│ ├── terraform.tfvars
│ └── variables.tf
├──lab16/
│ ├── .terraform/
│ │ └── modules/
│ │ │ ├── modules.json
│ │ │ └── providers/
│ │ │ ├── LICENSE.txt
│ │ │ └── terraform-provider-aws_v5.99.1_x5.exe
  └── modules/
│ ├── compute/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ ├── network/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ ├── .terraform.lock.hcl
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ ├── provider.tf
│ │ ├── terraform.tfstate
│ │ ├── terraform.tfstate.backup
│ │ ├── terraform.tfvars
│ │ └── variables.tf
├── daily update.md
├── submission day 13.md
└── README.md
├── submission_template.md
└── tasks.md
```



