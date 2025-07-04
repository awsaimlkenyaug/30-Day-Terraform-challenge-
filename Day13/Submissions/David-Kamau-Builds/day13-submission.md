# Day 13 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 8, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [ ] Complete Chapter 6 (Pages 219-221)
- [x] Completed Required Hands-on Labs
- [x] Implemented secure management of sensitive data using AWS Secrets Manager
- [x] Ensured sensitive data is properly masked and encrypted in Terraform state files
- [x] Created IAM roles and policies for secure access to secrets
- [x] Integrated secrets management with the blue/green deployment infrastructure
- [x] Implemented secure user data scripts for retrieving secrets at runtime

## Infrastructure Details

### Secrets Management Architecture

- **Secret Store:** AWS Secrets Manager
- **Access Control:** IAM roles and instance profiles
- **Encryption:** Enabled for secrets and state files
- **Runtime Access:** EC2 instances retrieve secrets using AWS SDK

### Key Components

1. **Secrets Module:**
   - Creates and manages AWS Secrets Manager resources
   - Defines IAM roles and policies for secure access
   - Provides instance profiles for EC2 instances

2. **Sensitive Variable Handling:**
   - Variables marked with `sensitive = true` flag
   - Prevents exposure in logs and outputs
   - Input validation for password strength

3. **State File Security:**
   - S3 backend configuration with encryption
   - DynamoDB table for state locking
   - Sensitive outputs properly marked

4. **Runtime Secret Retrieval:**
   - User data scripts to fetch secrets at instance startup
   - Secure storage of retrieved secrets on instances
   - No hardcoded secrets in the infrastructure

## Technical Implementation

### AWS Secrets Manager Configuration

- JSON-formatted secrets for structured data
- Recovery window for accidental deletion protection
- Resource tagging for organization

### IAM Role and Policy Setup

- EC2 assume role policy
- Least privilege permissions for secret access
- Instance profiles for EC2 instances

### User Data Templates

- AWS CLI commands for secret retrieval
- Secure local storage of configuration
- No exposure of secrets in instance metadata

## Notes and Observations

This implementation demonstrates how to securely manage sensitive data in Terraform while maintaining the benefits of Infrastructure as Code. The approach ensures that:

1. Sensitive data is never exposed in version control or logs
2. Access to secrets is tightly controlled through IAM
3. Secrets are only accessible to the resources that need them
4. The infrastructure can be safely deployed without manual secret handling

Key advantages of this approach:

- Complete separation of infrastructure code and sensitive data
- Automated secret retrieval at runtime
- Simplified secret rotation and management
- Secure state file handling
- Compliance with security best practices

## Additional Resources Used
- AWS Secrets Manager Documentation
- Terraform Documentation
- Amazon Q

## Blog Post
- **Title:** Terraform Secrets: Keep your sensitive data safe (and Sound).
- **Link:** https://medium.com/@davidwashingtonkamau/terraform-secrets-keep-your-sensitive-data-safe-and-sound-77201ca25923

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/posts/davidwashingtonkamau_devops-terraform-security-activity-7338606739413483521-3DlL?utm_source=share&utm_medium=member_desktop&rcm=ACoAAE7Yhn0B4r6JF1eNqzo97b9jvzabJQMz9Z8

## Time Spent
- Reading: [0 hours]
- Design: 2 hours
- Implementation: 3 hours
- Testing: 1 hour
- Total: 6 hours

## Repository Structure

```
Day13/
   └── Submissions/
         └── David-Kamau-Builds/
               ├── modules/
               │   ├── blue-green-module/
               │   │   ├── main.tf
               │   │   ├── variables.tf
               │   │   ├── outputs.tf
               │   │   └── templates/
               │   │       └── user_data.sh.tpl
               │   └── secrets-module/
               │       ├── main.tf
               │       ├── variables.tf
               │       └── outputs.tf
               ├── production/
               │   ├── main.tf
               │   ├── secrets.tf
               │   ├── provider.tf
               │   ├── variables.tf
               │   └── terraform.tfvars.example
               ├── .gitignore
               ├── day13-submission.md
               └── README.md
```