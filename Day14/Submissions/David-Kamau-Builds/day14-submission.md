# Day 14 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 9, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [ ] Completed Chapter 7 sections on working with multiple providers
- [x] Completed required hands-on labs (Lab 15 and Lab 16)
- [x] Implemented Terraform configurations with multiple copies of the same provider
- [x] Successfully deployed resources across multiple AWS regions
- [x] Used provider aliases to manage different provider configurations
- [x] Ensured proper resource naming and tagging across regions
- [x] Integrated with existing blue/green deployment and secrets management modules

## Infrastructure Details

### Multi-Region Architecture

- **Regions:** US East (N. Virginia) and US West (Oregon)
- **Provider Configuration:** AWS provider with region-specific aliases
- **Resource Distribution:** Identical infrastructure deployed in both regions
- **Naming Convention:** Region-specific resource naming to avoid conflicts

### Key Components

1. **Provider Configuration:**
   - Provider aliases for different AWS regions
   - Explicit provider passing to modules
   - Version constraints for provider compatibility

2. **Networking Infrastructure:**
   - Region-specific VPCs with unique CIDR blocks
   - Public subnets in multiple availability zones
   - Internet gateways and route tables
   - Security groups for web servers and load balancers

3. **Application Deployment:**
   - Blue-Green deployment modules in each region
   - Region-specific load balancers and auto-scaling groups
   - Consistent application versions across regions

4. **Data Management:**
   - Region-specific databases with encrypted storage
   - Secrets management in each region
   - IAM roles and policies for secure access

## Technical Implementation

### Provider Aliases Configuration

```hcl
# (us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

# (us-west-2)
provider "aws" {
  region = "us-west-2"
  alias  = "west"
}
```

### Module Provider Passing

```hcl
module "east_deployment" {
  source = "../modules/blue-green-module"
  # Configuration parameters...
  
  providers = {
    aws = aws.east
  }
}
```

### Region-Specific Resource Configuration

```hcl
resource "aws_vpc" "east" {
  provider             = aws.east
  cidr_block           = "10.42.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "dkb-${var.environment}-vpc-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
  }
}
```

## Notes and Observations

This implementation demonstrates how to effectively use multiple copies of the same provider in Terraform to deploy resources across multiple AWS regions. The approach ensures that:

1. Resources are properly isolated between regions
2. Region-specific configurations are applied where needed
3. Resource naming and tagging is consistent and clear
4. Modules can be reused across regions with proper provider configuration

Key advantages of this approach:

- Improved disaster recovery capabilities
- Geographic distribution for lower latency
- Isolation of regional failures
- Consistent infrastructure across regions
- Simplified multi-region management through code

## Additional Resources Used
- AWS Multi-Region Architecture Documentation
- Terraform Provider Configuration Documentation
- HashiCorp Learn: Managing Multiple Regions
- Amazon Q

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post] 

## Time Spent
- Reading: 0 hour
- Design: 2 hours
- Implementation: 4 hours
- Total: 6 hours

## Repository Structure

```
Day14/
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
               ├── day14-submission.md
               └── README.md
```