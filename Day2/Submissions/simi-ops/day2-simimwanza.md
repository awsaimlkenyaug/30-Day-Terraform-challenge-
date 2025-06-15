# Day 2 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 28th May 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- [x] Completed Required Hands-on Labs
  - [x] Lab 01: Setup your AWS Account (if needed)
  - [x] Lab 02: Install AWS CLI
  - [x] Lab 03: Installing Terraform and set up Terraform with AWS
- [x] Set up AWS account
- [x] Install Terraform locally
- [x] Install and configure AWS CLI
- [x] Install Visual Studio Code (VSCode) and add the AWS plugin
- [x] Configure VSCode to work with AWS

## Setup Validation

### Terraform Installation
- **Version:** terraform v1.12.1
- **Installation Method:** Used CLI method to install on Codespaces and automated it to install it everytime I open it
- **Path:** 

### AWS CLI Configuration
- **Version:** aws-cli/2.27.24
- **Default Region:** us-west-2
- **Profile Configuration:** 1

### VSCode Configuration
- **Extensions Installed:** AWS Toolkit, HashiCorp Terraform
- **AWS Plugin Status:** Configured

## Configuration Files
Please place your configuration screenshots and validation files in the `setup-validation` folder:
- `terraform-version.txt` - Output of `terraform version`
- `aws-config-validation.txt` - Output of `aws sts get-caller-identity` (sanitized)
- `vscode-extensions.png` - Screenshot of installed extensions

## Blog Post
- **Title:** Step-by-Step Guide to Setting Up Terraform, AWS CLI, and Your AWS Environment.
- **Link:** [Hashnode](https://simiops.hashnode.dev/step-by-step-guide-to-setting-up-terraform-aws-cli-and-your-aws-environment?showSharer=true)

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1928078810173378995

## Notes and Observations
- Alreasy had an AWS Account so setting up the rest was easy
- Automated the installation of the extensions and installation of AWS and Terraform on startup using devcontainer

## Additional Resources Used
- https://code.visualstudio.com/docs/devcontainers/create-dev-container

## Time Spent
- Reading: [2 hours]
- AWS Account Setup: [1 hours]
- Terraform Installation: [0.15 hours]
- AWS CLI Configuration: [0.15 hours]
- VSCode Setup: [0.15 hours]
- Blog Writing: [2 hours]
- Total: [5.45 hours]

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
- Used AI to generate the devcontainer JSON


