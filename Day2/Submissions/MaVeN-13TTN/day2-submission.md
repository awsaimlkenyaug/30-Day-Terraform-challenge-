# Day 2 Submission

## Personal Information
- **Name:** Ndungu Kinyanjui
- **Date:** May 28, 2025
- **GitHub Username:** MaVeN-13TTN

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running" (Setting Up Your AWS Account & Installing Terraform)
- [x] Completed Required Hands-on Labs
  - [x] Lab 01: Setup your AWS Account (completed Day 1)
  - [x] Lab 02: Install AWS CLI (completed Day 1)
  - [x] Lab 03: Installing Terraform and set up Terraform with AWS
- [x] Set up AWS account (completed Day 1)
- [x] Install Terraform locally (completed Day 1)
- [x] Install and configure AWS CLI (completed Day 1)
- [x] Install Visual Studio Code (VSCode) and add the AWS plugin (completed Day 1)
- [x] Configure VSCode to work with AWS

## Setup Validation

### Terraform Installation
- **Version:** Terraform v1.12.1
- **Installation Method:** Downloaded from HashiCorp releases
- **Path:** /usr/local/bin/terraform
- **Provider Version:** AWS provider v5.98.0
- **Status:** ✅ Configured and tested

### AWS CLI Configuration
- **Version:** aws-cli/2.24.3 Python/3.12.6 Linux/6.11.0-26-generic
- **Default Region:** us-east-1
- **Profile Configuration:** 1 profile (default)
- **Authentication:** ✅ Verified with sts get-caller-identity
- **Account ID:** 216989107230
- **User:** titan_user

### VSCode Configuration
- **Version:** 1.100.2
- **Extensions Installed:** 
  - hashicorp.terraform
  - pjmiravalle.terraform-advanced-syntax-highlighting
- **AWS Plugin Status:** ✅ Configured
- **Terraform Support:** ✅ Syntax highlighting and validation enabled

## Configuration Files
Configuration validation files are located in the `setup-validation` folder:
- ✅ `terraform-version.txt` - Terraform installation details
- ✅ `aws-config-validation.txt` - AWS CLI configuration proof (sanitized)
- ✅ `provider-test.tf` - Terraform provider validation configuration
- ✅ `validation-script.sh` - Comprehensive setup validation script

## Blog Post
- **Title:** "Advanced Terraform & AWS Setup: Professional Development Environment"
- **Link:** https://maven-13ttn.github.io/blog/post.html?post=advanced-terraform-aws-setup-blog
- **Status:** ✅ Published on GitHub Pages

## Social Media
- **Platform:** Twitter/X
- **Post:** "💻 Enhanced my Terraform setup with advanced validation and testing! Ready for professional infrastructure deployment. #TerraformSetup #AWS #DevOps #Day2Challenge"
- **Link:** https://x.com/Maven_TTN/status/1927696763697135647

## Notes and Observations
Day 2 focused on advancing beyond basic setup to create a professional-grade development environment. Key achievements include:

1. **Advanced Validation**: Created comprehensive testing procedures to ensure all components work together
2. **Provider Configuration**: Set up and tested AWS provider connectivity 
3. **Professional Tooling**: Enhanced VSCode with proper extensions for Terraform development
4. **Documentation**: Created validation scripts for reproducible environment verification

The setup now includes proper provider configuration, connectivity testing, and validation procedures that would be used in professional environments.

## Additional Resources Used
- HashiCorp Terraform Provider Documentation
- AWS CLI Configuration Best Practices
- VSCode Terraform Extension Documentation
- Terraform Validation and Testing Guides

## Time Spent
- Reading: 1.5 hours
- AWS Account Setup: 0 hours (completed Day 1)
- Terraform Installation: 0 hours (completed Day 1)
- AWS CLI Configuration: 0 hours (completed Day 1)
- VSCode Setup: 0.5 hours (extensions and advanced config)
- Advanced Configuration & Testing: 2 hours
- Validation Scripts: 1 hour
- Documentation: 1 hour
- Blog Writing: 2 hours
- Total: 8 hours

## Repository Structure
```
Day2/
└── Submissions/
    └── MaVeN-13TTN/
        ├── setup-validation/
        │   ├── terraform-version.txt
        │   ├── aws-config-validation.txt
        │   ├── provider-test.tf
        │   ├── .terraform.lock.hcl
        │   └── validation-script.sh
        ├── daily-update.md
        └── day2-submission.md
```

## Setup Validation Commands
Commands used to validate the setup:

```bash
# Terraform validation
terraform version
terraform providers
terraform init
terraform validate
terraform plan

# AWS CLI validation  
aws --version
aws sts get-caller-identity
aws configure list

# VSCode validation
code --version
code --list-extensions | grep -E "(aws|terraform)"
```

## Troubleshooting Notes
1. **Provider Configuration**: Initially encountered "No configuration files" error when running `terraform providers` without a .tf file
   - **Solution**: Created provider-test.tf with basic AWS provider configuration

2. **Extension Management**: Verified proper Terraform extensions are installed for optimal development experience
   - **Solution**: Confirmed hashicorp.terraform and advanced syntax highlighting extensions

3. **Connectivity Testing**: Needed to verify AWS authentication works through Terraform
   - **Solution**: Created data source test with aws_caller_identity to validate connectivity

## Advanced Configuration Benefits
- ✅ Reproducible environment validation
- ✅ Professional development setup
- ✅ End-to-end connectivity testing
- ✅ Automated validation procedures
- ✅ Ready for infrastructure deployment tasks
