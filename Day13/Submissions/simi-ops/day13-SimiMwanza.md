# Day 13 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 9th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 6 (Pages 191-221)
- [x] Completed Required Hands-on Labs (Lab 14: Module Versioning, Lab 15: Terraform Testing)
- [x] Implemented secure management of sensitive data using AWS Secrets Manager
- [x] Ensured sensitive data is properly masked and encrypted in Terraform state files

## Infrastructure Details

### Secure Secrets Management with AWS Secrets Manager

Successfully implemented secure secrets management using:

1. **AWS Secrets Manager Integration**
   - Secrets stored encrypted in AWS Secrets Manager
   - Automatic encryption at rest using AWS KMS
   - Environment-specific secret recovery policies (30 days for production, 0 for dev)

2. **IAM Role-Based Access Control**
   - EC2 instances use IAM roles to access secrets
   - Principle of least privilege applied
   - Instance profiles attached to launch templates

3. **Terraform State Security**
   - Sensitive variables marked with `sensitive = true`
   - Secrets masked in Terraform plan/apply output
   - State file encryption enabled in S3 backend

4. **Runtime Secret Retrieval**
   - Secrets retrieved dynamically during instance startup
   - Configuration files secured with proper permissions (600)
   - No hardcoded credentials in code or user data

5. **Environment Separation**
   - Different secrets per environment (dev, staging, production)
   - Separate IAM roles and policies per environment
   - Secrets files excluded from version control

6. **Security Features Implemented**
   - ✅ AWS Secrets Manager for encrypted secret storage
   - ✅ IAM role-based access with minimal permissions
   - ✅ Sensitive data masking in Terraform state
   - ✅ Runtime secret retrieval (no secrets in code)
   - ✅ Environment-specific secret management
   - ✅ Proper file permissions and security controls


## Infrastructure Diagram
Please see the `architecture/web-server.png` file for the infrastructure diagram.

## Blog Post
- **Title:** "How to Handle Sensitive Data Securely in Terraform"
- **Link:** [Blog Post](https://simiops.hashnode.dev/how-to-handle-sensitive-data-securely-in-terraform)

## Social Media
- **Platform:** Twitter
- **Post Link:** [Twitter Post](https://x.com/simiOps/status/1938574976019230970)

## Notes and Observations

### Secure Secrets Management Implementation
- Successfully integrated AWS Secrets Manager for encrypted secret storage
- Implemented IAM role-based access control with principle of least privilege
- Ensured sensitive data is properly masked in Terraform state files
- Created runtime secret retrieval mechanism for enhanced security
- Established environment-specific secret management practices

### Key Security Achievements
- ✅ AWS Secrets Manager integration with KMS encryption
- ✅ IAM roles and policies for secure secret access
- ✅ Sensitive variable masking in Terraform state
- ✅ Runtime secret retrieval (no hardcoded secrets)
- ✅ Environment separation for secrets
- ✅ Security documentation and best practices
- ✅ Proper file permissions and access controls
- ✅ Version control exclusion of sensitive files


## Additional Resources Used
- Terraform Documentation: https://www.terraform.io/docs/language/expressions/conditionals.html
- AWS Architecture Best Practices: https://aws.amazon.com/architecture/well-architected/

## Time Spent
- Reading: [2 hours]
- Infrastructure Refactoring: [4 hours]
- Zero Downtime Implementation: [3 hours]
- Troubleshooting & Testing: [2 hours]
- Diagram Creation: [1 hour]
- Blog Writing: [2 hours]
- Total: [14 hours]

## Repository Structure
```
terraform/
├── main.tf                     # Main Terraform configuration with conditional resource deployment
├── variables.tf                # Variable definitions including environment-specific settings
├── deploy.sh                   # Deployment script for different environments
├── README.md                   # Documentation
├── environments/               # Environment-specific configurations
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── terraform.tfvars
│   └── production/
│       └── terraform.tfvars
├── modules/                    # Reusable Terraform modules with conditional logic
│   ├── alb/                    # Application Load Balancer module
│   │   ├── main.tf            # Includes conditional health checks and listeners
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── asg/                    # Auto Scaling Group module
│   │   ├── main.tf            # Launch Templates with IAM instance profiles
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/                    # EC2 instance module
│   │   ├── main.tf            # Includes conditional instance counts and volume configurations
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data.sh       # Updated with secret retrieval logic
│   ├── secrets/                # Secrets management module (NEW)
│   │   ├── main.tf            # AWS Secrets Manager and IAM configuration
│   │   ├── variables.tf       # Sensitive variables with proper marking
│   │   └── outputs.tf         # Secure outputs for secret access
│   └── security_group/         # Security Group module
│       ├── main.tf            # Includes conditional security rules based on environment
│       ├── variables.tf
│       └── outputs.tf
```