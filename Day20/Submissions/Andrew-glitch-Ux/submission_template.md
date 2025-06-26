# Day 20 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [26-06-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Read Chapter 10 of "Terraform: Up & Running"
- [X] Completed Required Hands-on Labs
- [X] Lab 23: Single Server Deployment using Terraform Cloud
- [X] lab 24 : set poilicies to same infra on lab 23
- [X] Created Infrastructure Diagrams

## Infrastructure Details

### Lab 23: Single Server Deployment using Terraform Cloud

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



## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7344111912843956225/ ]

## Notes and Observations
[
- Deployed using `terraform apply` triggered via GitHub push.
- Region issues were resolved by ensuring `HCL` was enabled in variable inputs.
- Deployment succeeded after resolving region and CIDR format issues.
- Successfully implemented a Sentinel policy to restrict EC2 instance types to `t3.micro`, ensuring consistent instance provisioning.
-  Gained hands-on experience with policy enforcement modes (`advisory`, `soft-mandatory`, and `hard-mandatory`) and their effects on Terraform runs.
-  Validated policy blocking behavior by pushing a non-compliant instance type and confirming Terraform Cloud rejected the plan.

###  Challenges Faced:
-  Faced policy application failure due to a misconfigured `instance_type`, which required troubleshooting Sentinel logic and re-validating runs.
-  Encountered confusion navigating Terraform Cloud UI for attaching policy sets and understanding run feedback from failed policy enforcement.
]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Reading: [1 hours]
- Infrastructure Deployment: [1/2 hours]
- Diagram Creation: [1/2 hours]
- Blog Writing: [20 mins]
- Total: [1 hours 50 mins]

## Repository Structure
```
Day20/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── lab23.drawio.png
        │   └── 
        ├──lab 23
            ├── terraform/   
                ├──providers
                   ├──LICENSE.txt
                ├──environment
                ├──terraform.tfstate
                ├──.terraform.lock.hcl
                ├──main.tf
                ├──terraform.tfvars
                ├──varaiables.tf
        ├──lab 22
           ├──main.tf
           ├──terraform.tfvars
           ├──varaiables.tf
        └──  daily update.md
        └── submission.md
    ├──README.md
    ├──submission_template.md
├──README.md
├──tasks.md
``` 
