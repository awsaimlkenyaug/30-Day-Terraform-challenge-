# Day 2 Submission

## Personal Information
- **Name:** ALLAN CHERUIYOT
- **Date:** 5/30/2025
- **GitHub Username:** ALLAN69CHERUIYOT

## Task Completion
- [✔️ ] Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- [✔️ ] Completed Required Hands-on Labs
  - [✔️ ] Lab 01: Setup your AWS Account (if needed)
  - [✔️ ] Lab 02: Install AWS CLI
  - [✔️ ] Lab 03: Installing Terraform and set up Terraform with AWS
- [ ✔️] Set up AWS account
- [✔️] Install Terraform locally
- [✔️ ] Install and configure AWS CLI
- [✔️ ] Install Visual Studio Code (VSCode) and add the AWS plugin
- [ ✔️] Configure VSCode to work with AWS

## Setup Validation

### Terraform Installation
- **Version:** Terraform v1.12.1
- **Installation Method:** Downloaded binary
- **Path:** C:\terraform

### AWS CLI Configuration
- **Version:** aws-cli/2.27.22 Python/3.13.3 Windows/11 exe/AMD64
- **Default Region:**us-east-1
- **Profile Configuration:** 1

### VSCode Configuration
- **Extensions Installed:** AWS Toolkit, HashiCorp Terraform extensions
- **AWS Plugin Status:** Configured

## Configuration Files
Please place your configuration screenshots and validation files in the `setup-validation` folder:
- `terraform-version.txt` - Output of `terraform version`
- `aws-config-validation.txt` - Output of `aws sts get-caller-identity` (sanitized)
- `vscode-extensions.png` - Screenshot of installed extensions

## Blog Post
- **Title:** Step-by-Step Guide to Setting Up Terraform, AWS CLI, and Your AWS Environment
- **Link:** https://allan-blog.hashnode.dev/step-by-step-guide-to-setting-up-terraform-aws-cli-and-your-aws-environment

## Social Media
- **Platform:** LinkedIn
- **Post Link:**  https://www.linkedin.com/posts/allan-cheruiyot-730896331_terraformsetup-aws-devops-activity-7333550431786172419-FdaF?utm_source=share&utm_medium=member_desktop&rcm=ACoAAFOaNZQBPsFm1zkiP9oxzdKTVE9IbqnDYZU

## Notes and Observations
For Day 2, I focused on reinforcing my setup knowledge. I revisited the process of setting up my AWS account, installing Terraform and the AWS CLI, and configuring VSCode. This hands-on review confirmed my environment was fully ready. The labs involved deploying both a single server and a basic web server architecture using Terraform, which helped me practice defining resources and applying configurations. I found the diagramming a good way to visualize the infrastructure before and after deployment.

## Additional Resources Used
- AWS EC2 User Guide
- Terraform documentation user Guide
- Youtube video


## Time Spent
- Reading: [2 hours]
- AWS Account Setup: [3 hours]
- Terraform Installation: [30 minutes]
- AWS CLI Configuration: [30 minutes]
- VSCode Setup: [30 minutes]
- Blog Writing: [30 minutes]
- Total: [7 hours]

## Repository Structure
```
Day2/
└── Submissions/
    └── [Your GitHub Username]/
        ├── setup-validation/
        │   ├── terraform-version.txt
        │   ├── aws-config-validation.txt
        │   └── vscode-extensions.png
        ├── daily-update.md
        └── submission.md
```

## Setup Validation Commands
Document the commands you used to validate your setup:

```bash
# Terraform validation
terraform version
terraform providers

# AWS CLI validation  
aws --version
aws sts get-caller-identity
aws configure list

# VSCode validation
code --version
code --list-extensions | grep -E "(aws|terraform)"
```

## Troubleshooting Notes
Issue: Initially, aws sts get-caller-identity returned a configuration error.
Resolution: Realized the AWS CLI was installed but not configured with credentials. Ran aws configure and provided Access Key ID, Secret Access Key, and default region (us-east-1). After re-running aws sts get-caller-identity, it successfully returned my account details.



