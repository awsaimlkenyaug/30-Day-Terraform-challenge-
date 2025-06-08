# Day 2 Submission

## Personal Information
- **Name:** [Your Name]
- **Date:** [Date of Submission]
- **GitHub Username:** [Your GitHub Username]

## Task Completion
- [ ] Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- [ ] Completed Required Hands-on Labs
  - [ ] Lab 01: Setup your AWS Account (if needed)
  - [ ] Lab 02: Install AWS CLI
  - [ ] Lab 03: Installing Terraform and set up Terraform with AWS
- [ ] Set up AWS account
- [ ] Install Terraform locally
- [ ] Install and configure AWS CLI
- [ ] Install Visual Studio Code (VSCode) and add the AWS plugin
- [ ] Configure VSCode to work with AWS

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
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
[Share your key learnings, challenges faced, and how you overcame them during the setup process]

## Additional Resources Used
[List any additional resources you found helpful for setup and configuration]

## Time Spent
- Reading: [X hours]
- AWS Account Setup: [X hours]
- Terraform Installation: [X hours]
- AWS CLI Configuration: [X hours]
- VSCode Setup: [X hours]
- Blog Writing: [X hours]
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



