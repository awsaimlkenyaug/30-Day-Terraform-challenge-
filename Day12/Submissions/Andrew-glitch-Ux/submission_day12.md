# Day 12 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [11/06/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 5 of "Terraform: Up & Running"
- [x] Completed Lab 13: Basic ASG with ALB Setup
- [x] Completed Lab 14: Zero-Downtime Deployment with ASG, ALB, and Launch Templates
- [x] Created infrastructure diagrams for both labs
- [x] Validated and applied Terraform configurations successfully

## Infrastructure Details

### Lab 13: Basic Auto Scaling Group + ALB Setup
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:**
  - VPC with public subnets
  - Internet Gateway and route table
  - Application Load Balancer (ALB) with HTTP listener
  - Target Group linked to ALB
  - Launch Template and Auto Scaling Group
  - EC2 instances via ASG
  - Security Groups for EC2 and ALB
  - user_data to install and serve a simple web server

### Lab 14: Zero-Downtime Deployment with ASG and Launch Template Versioning
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:**
  - Reuse of VPC, subnets, and IGW from Lab 13
  - Launch Template with version-aware `user_data`
  - Updated ASG strategy to support rolling deployments
  - ALB health checks to manage instance traffic
  - EC2 instances replaced without downtime
  - Verified deployment using ALB DNS

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `lab13.png` - Diagram for Lab 13: ASG + ALB Setup
- `lab14.png` - Diagram for Lab 14: Zero-Downtime Deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7338524608637059072/ ]

## Notes and Observations
- Learned how to properly define and use modules in Terraform
- Gained clarity on how ALBs and ASGs integrate
- Understood the impact of `user_data` changes on ASG behavior
- Faced errors with module outputs and paths; resolved using correct outputs and file checks
- Successfully implemented a zero-downtime rollout using versioned launch templates

## Additional Resources Used
- Terraform documentation
- AWS documentation for ALB, ASG, and launch templates

## Time Spent
- Reading: 1.5 hours
- Infrastructure Deployment: 2 hours
- Diagram Creation: 1 hour
- Blog Writing: 0 hours
- Total: 4.5 hours

## Repository Structure
```
Day12/
└── Submissions/
    └── [Andrew-glitch-Ux]/
           Architecture
             lab 13o.drawio.png
             lab14.drawio.png
           lab13
             live
               dev 
                .terraform
                   modules
                     modules.json
                   providers
                     aws
                      LICENSE.txt
                      terraform-provider-aws_v5.99.1_x5.exe
                     template
                      terraform-provider-template_v2.2.0_x4.exe
                .terraform.lock.hcl
                main.tf
                outputs.tf
                provider.tf
                terraform.tfstate
                terraform.tfstate.backup
                terraform.tfvars
                variables.tf
             modules
              vpc
               main.tf
               outputs.tf
               variables.tf 
              web-server
               main.tf
               outputs.tf
               user_data.sh
               variables.tf
            lab14
             live
               dev
                .terraform
                   modules
                    modules.json
                   providers
                    LICENSE.txt
                    terraform-provider-aws_v5.99.1_x5.exe
                .terraform.lock.hcl
                .terraform.tfstate.lock.info   
                main.tf
                outputs.tf
                provider.tf
                terraform.tfstate
                terraform.tfvars
                variables.tf
             modules
               alb
                 main.tf
                 outputs.tf
                 varibles.tf
               asg
                 main.tf
                 outputs.tf
                 user_data.sh
                 varibles.tf
               vpc
                 main.tf
                 outputs.tf
                 varibles.tf
            daily update.md
            submission_day12.md
        README.md
        submission_template.md   
    README.md
    tasks.md 
```
