# Day 14 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 10th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 6 (Pages 191-221)
- [x] Completed Required Hands-on Labs (Lab 14: Module Versioning, Lab 15: Terraform Testing)
- [x] Implemented secure management of sensitive data using AWS Secrets Manager
- [x] Ensured sensitive data is properly masked and encrypted in Terraform state files
- [x] Set up multi-region deployment using multiple AWS provider instances

## Infrastructure Details

### Multi-Region Deployment with Multiple AWS Providers

Successfully implemented multi-region infrastructure using:

1. **Multiple Provider Configuration**
   - Primary AWS provider for main region deployment
   - Secondary AWS provider with alias "backup" for disaster recovery
   - Region-specific default tags and configurations


## Infrastructure Diagram
Please see the `architecture/web-server.png` file for the infrastructure diagram.

## Blog Post
- **Title:** "Managing Multi-Region Deployments with Terraform Providers"
- **Link:** [Blog Post](https://simiops.hashnode.dev/managing-multi-region-deployments-with-terraform-providers)

## Social Media
- **Platform:** Twitter
- **Post Link:** [Twitter Post](https://x.com/simiOps/status/1938591317191242128)

## Notes and Observations

### Multi-Region Provider Implementation
- Successfully configured multiple AWS provider instances with aliases
- Implemented conditional multi-region deployment for production environment

### Key Multi-Region Achievements
- ✅ Multiple AWS provider configuration (primary + backup)
- ✅ Conditional deployment based on environment
- ✅ Region-specific AMI data sources
- ✅ Independent secrets management per region
- ✅ Cost-optimized multi-region strategy
- ✅ Provider aliases for resource targeting
- ✅ Region-specific tagging and configurations


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