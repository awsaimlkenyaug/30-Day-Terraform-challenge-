# Day 15 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [16/06/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Read Chapter 7 of "Terraform: Up & Running"
- [X] Completed Required Hands-on Labs
- [X] Multi-Region Server DeploymentMulti-Region Server Deployment
- [X] Deployed Web Server
- [X] Created Infrastructure Diagrams

## Infrastructure Details

### Multi-Region Server DeploymentMulti-Region Server Deployment
- Deployed VPCs in eu-north-1 & eu-west-1
- Launched EC2 instances in both regions
- Used provider aliases for multi-region setup
- Applied Terraform modules with region isolation
- Injected all config via tfvars for flexibility

### Multi-Cloud Kubernetes Setup
Initialized a multi-cloud project structure (AWS + GCP)
Configured multiple Terraform providers (aws, google, kubernetes)
Prepared EKS deployment for Docker container workloads
Isolated cloud logic into separate Terraform files
Injected all cloud variables via .tfvars for flexibility

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7340797646627926017]

## Notes and Observations
[Deployed EKS cluster across two AZs to meet AWS requirement for high availability.
Subnet CIDRs were separated (10.0.1.0/24, 10.0.2.0/24) to avoid conflicts and enable multi-AZ deployment.
All configuration values were injected via terraform.tfvars for reusability and cleaner code (no hardcoding).
GCP resources were defined but commented out, enabling future multi-cloud expansion without deploying now.
Encountered and resolved subnet conflict and AZ errors, highlighting the importance of correct CIDR ranges and AZ distribution for EKS.]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Reading: [30 mins]
- Infrastructure Deployment: [1 hour]
- Diagram Creation: [20 mins]
- Blog Writing: [10 mins]
- Total: [2 hours]

## Repository Structure
```
Day15/
└── Submissions/
└── Andrew-glitch-Ux/
├── Architecture/
│ ├── Lab16-Multi-Provider.drawio
│ └── lab17drawio.png
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
├── submission day 13.md
└── README.md
├── submission_template.md
└── tasks.md
```







