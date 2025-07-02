# Day 11 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 7th June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 5 (Pages 160-169)
- [x] Completed Required Hands-on Labs
- [x] Refactored Terraform code to use conditionals for dynamic infrastructure deployment

## Infrastructure Details

### Dynamic Infrastructure with Conditionals
I've refactored the Terraform code to use conditionals for dynamic infrastructure deployment across different environments (dev, staging, production). The key features include:

1. **Environment-specific Resource Deployment**
   - Different instance types and counts based on environment
   - Additional EBS volumes only in staging and production
   - ALB deployment optional in dev environment

2. **Security Controls Based on Environment**
   - Restricted SSH access in production (only from internal networks)
   - Additional security group rules for monitoring in non-dev environments
   - Environment-specific health check configurations

3. **Performance and Reliability Features**
   - Enhanced monitoring in production
   - Backup plans only in production
   - Different root volume sizes and types based on environment

## Infrastructure Diagram
Please see the `architecture/web-server.png` file for the infrastructure diagram.

## Blog Post
- **Title:** "Mastering Terraform Conditionals for Dynamic Infrastructure"
- **Link:** [Blog Post](https://simiops.hashnode.dev/mastering-terraform-conditionals-for-dynamic-infrastructure?showSharer=true)

## Social Media
- **Platform:** Twitter
- **Post Link:** [Twitter Post](https://x.com/simi_mwanza/status/1934580430474473849)

## Notes and Observations
The use of conditionals in Terraform significantly improves the flexibility and reusability of infrastructure code. By implementing environment-specific configurations through conditionals, I was able to:

1. Reduce code duplication across environments
2. Implement cost optimization by only deploying necessary resources in each environment
3. Apply appropriate security controls based on the environment's requirements
4. Create a more maintainable codebase that can adapt to different deployment scenarios

Conditionals are particularly powerful when combined with variables and locals to create dynamic infrastructure that responds to different inputs and requirements.

## Additional Resources Used
- Terraform Documentation: https://www.terraform.io/docs/language/expressions/conditionals.html
- AWS Architecture Best Practices: https://aws.amazon.com/architecture/well-architected/

## Time Spent
- Reading: [2 hours]
- Infrastructure Refactoring: [4 hours]
- Diagram Creation: [1 hour]
- Blog Writing: [2 hours]
- Total: [9 hours]

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
│   ├── ec2/                    # EC2 instance module
│   │   ├── main.tf            # Includes conditional instance counts and volume configurations
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── user_data.sh
│   └── security_group/         # Security Group module
│       ├── main.tf            # Includes conditional security rules based on environment
│       ├── variables.tf
│       └── outputs.tf
```