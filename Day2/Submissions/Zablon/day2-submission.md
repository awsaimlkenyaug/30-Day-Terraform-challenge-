# Day 2 Submission

## Personal Information
- **Name:** Zablon
- **Date:** 2-06-2025
- **GitHub Username:** [zablon-oigo](https://github.com/zablon-oigo)

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
- **Version:** 1.12
- **Installation Method:** 
- **Path:** C:\terraform

### AWS CLI Configuration
- **Version:** 2.15
- **Default Region:** us-east-1
- **Profile Configuration:** 1

### VSCode Configuration
- **Extensions Installed:** AWS, Terraform 
- **AWS Plugin Status:** Configured

## Configuration Files
Please place your configuration screenshots and validation files in the `setup-validation` folder:
- `terraform-version.txt` - Output of `terraform version`
- `aws-config-validation.txt` - Output of `aws sts get-caller-identity` (sanitized)
- `vscode-extensions.png` - Screenshot of installed extensions

## Blog Post
- **Title:** Getting Started with Terraform
- **Link:** [Getting Started with Terraform](https://medium.com/@zablon-oigo/getting-started-with-terraform-a-beginners-guide-0d93b1d2f414)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [LinkedIn](https://www.linkedin.com/posts/zablon-oigo_terraformsetup-aws-devops-activity-7333198144966389760-dK9O?utm_source=share&utm_medium=member_desktop&rcm=ACoAADpqOqwBjFTtzGtUYa4fYatIdIjqmNvTU1c)

## Notes and Observations
#### key learnings
Gained hands-on experience setting up Terraform and configuring it for use in the terminal.

## Additional Resources Used
[Terraform Docs](https://developer.hashicorp.com/terraform/docs)

## Time Spent
- Reading: 2 hrs 30 min
- AWS Account Setup: 10 min
- Terraform Installation: 5 min
- AWS CLI Configuration: 5 min
- VSCode Setup: 5 min
- Blog Writing: 2 hours
- Total: 4hrs 55 min

## Repository Structure
```
Day2/
└── Submissions/
    └── [zablon]/
        ├── setup-validation/
        │   ├── terraform-version.txt
        │   ├── aws-config-validation.txt
        │   └── vscode-extensions.md
        ├── daily-update.md
        └── day2-submission.md
```

## Setup Validation Commands
Document the commands you used to validate your setup:

```bash
# Terraform validation
terraform --version

# AWS CLI validation  
aws --version

```

## Troubleshooting Notes
#### Add Terraform to Environment Variables

- Press Windows Key + S, search “Environment Variables”, then click “Edit the system   environment variables”
- Click “Environment Variables…”
- Under System variables, select Path > Edit > New
- Add the path to your Terraform folder (e.g., C:\terraform)
- Click OK on all dialogs







