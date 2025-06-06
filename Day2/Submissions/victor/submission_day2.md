# Day 2 Submission

## Personal Information
- **Name:** Victor kimari
- **Date:** 28/05/2025
- **GitHub Username:** UX_UI

## Task Completion
- * Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- * Completed Required Hands-on Labs
  -  Lab 01: Setup your AWS Account (if needed)
  -  Lab 02: Install AWS CLI
  -  Lab 03: Installing Terraform and set up Terraform with AWS
- * Set up AWS account
- * Install Terraform locally
- * Install and configure AWS CLI
- * Install Visual Studio Code (VSCode) and add the AWS plugin
- * Configure VSCode to work with AWS

## Setup Validation

### Terraform Installation
- **Version:** Terraform v1.11.4
- **Installation Method:** downloaded from the website
- **Path:** C:\Users\PC\Terraform

### AWS CLI Configuration
- **Version:** aws-cli/2.27.8
- **Default Region:** us-east-1
- **Profile Configuration:** 1

### VSCode Configuration
- **Extensions Installed:** aws cli, github
- **AWS Plugin Status:** Configured

## Configuration Files
Please place your configuration screenshots and validation files in the `setup-validation` folder:
- `terraform-version.txt` - Output of `terraform version`
- `aws-config-validation.txt` - Output of `aws sts get-caller-identity` (sanitized)
- `vscode-extensions.png` - Screenshot of installed extensions

## Blog Post
- **Title:** Terraform and AWS CLI Essentials: Your First Steps into Cloud Automation
- **Link:** https://medium.com/@gkimari041/terraform-and-aws-cli-essentials-your-first-steps-into-cloud-automation-adca6487f922

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** https://www.linkedin.com/posts/kimari-victor-364b2225b_30daytfchallenge-hug-hashicorp-activity-7333164466966032386-ZW0j?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAPZXwB6Xku6ha9P_KUA1GGGJHk1j8rpm4

## Notes and Observations
Configuring aws was bit of a challenge but I managed 

## Additional Resources Used
[List any additional resources you found helpful for setup and configuration]

## Time Spent
- Reading: [1 hour]
- AWS Account Setup: [1 hour]
- Terraform Installation: [1 hour]
- AWS CLI Configuration: [1 hour]
- VSCode Setup: [1 hour]
- Blog Writing: [1 hour]
- Total: [6 hours]

## Repository Structure
```
Day2/
└── Submissions/
    └── UX_UI/
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
[Document any issues you encountered and how you resolved them] 



