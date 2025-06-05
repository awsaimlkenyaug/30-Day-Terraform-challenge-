# Day 2 Submission

## Personal Information
- **Name:** [LYNN KATHOMI]
- **Date:** [5/6/2025]
- **GitHub Username:** [https://github.com/lynnkathomi]

## Task Completion
- [X] Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- [X] Completed Required Hands-on Labs
  - [X] Lab 01: Setup your AWS Account (if needed)
  - [X] Lab 02: Install AWS CLI
  - [X] Lab 03: Installing Terraform and set up Terraform with AWS
- [X] Set up AWS account
- [X] Install Terraform locally
- [X] Install and configure AWS CLI
- [X] Install Visual Studio Code (VSCode) and add the AWS plugin
- [X] Configure VSCode to work with AWS

## Setup Validation

### Terraform Installation
- **Version:** [Terraform version installed]
- **Installation Method:** [How you installed Terraform]
- **Path:** [Where Terraform is installed]

### AWS CLI Configuration
- **Version:** [AWS CLI version]
- **Default Region:** [Your default AWS region]
- **Profile Configuration:** [Number of profiles configured]

### VSCode Configuration
- **Extensions Installed:** [List AWS and Terraform related extensions]
- **AWS Plugin Status:** [Configured/Not Configured]

## Configuration Files
Please place your configuration screenshots and validation files in the `setup-validation` folder:
- `terraform-version.txt` - Output of `terraform version`
- `aws-config-validation.txt` - Output of `aws sts get-caller-identity` (sanitized)
- `vscode-extensions.png` - Screenshot of installed extensions

## Blog Post
- **Title:** [Deploying Your First Server with Terraform: A Beginner’s Guide]
- **Link:** [https://medium.com/@lynnkathomi/deploying-your-first-server-with-terraform-a-beginners-guide-b615713f76bf]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
[Share your key learnings, challenges faced, and how you overcame them during the setup process]

## Additional Resources Used
[List any additional resources you found helpful for setup and configuration]

## Time Spent
-Reading: [1 hours]
- Infrastructure Deployment: [30min]
- Diagram Creation: [45min]
- Blog Writing: [45min]
- Total: [X hours]

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
[Document any issues you encountered and how you resolved them] 



