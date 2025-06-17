# Day 15: Working with Multiple Providers - Part 2

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 12, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [ ] Completed Chapter 7 of "Terraform: Up & Running"
- [x] Rewatched the videos on Terraform modules
- [x] Successfully created and deployed multi-provider Terraform modules
- [x] Deployed Docker containers and Kubernetes clusters using Terraform
- [ ] Written and published a blog post about today's task
- [ ] Made a social media post about today's task
- [x] Created a day15-submission.md file with my Terraform code
- [ ] Prepared questions for tomorrow's live session
- [ ] Created a pull request with all the required details

## Infrastructure Details

### Multi-Provider Architecture

- **Cloud Providers:** AWS (us-east-1 and us-west-2) and Google Cloud Platform
- **Provider Configuration:** AWS provider with region-specific aliases and GCP provider
- **Resource Distribution:** Infrastructure deployed across multiple cloud providers
- **Naming Convention:** Provider and region-specific resource naming to avoid conflicts

### Key Components

1. **Provider Configuration:**
   - AWS provider with region-specific aliases
   - Google Cloud Platform provider
   - Explicit provider passing to modules
   - Version constraints for provider compatibility

2. **Networking Infrastructure:**
   - Region-specific VPCs with unique CIDR blocks in AWS
   - GCP VPC networks and subnets
   - Public subnets in multiple availability zones
   - Internet gateways and route tables
   - Security groups for web servers and load balancers

3. **Container Orchestration:**
   - AWS EKS cluster for Kubernetes in us-east-1
   - GCP GKE cluster for Kubernetes
   - Docker container deployments
   - Kubernetes services and deployments

4. **Application Deployment:**
   - Blue-Green deployment modules in each AWS region
   - Region-specific load balancers and auto-scaling groups
   - Consistent application versions across regions

5. **Data Management:**
   - Region-specific databases with encrypted storage
   - Secrets management in each region
   - IAM roles and policies for secure access

## Technical Implementation

### Multi-Provider Configuration

```hcl
terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# AWS us-east-1 provider
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

# AWS us-west-2 provider
provider "aws" {
  region = "us-west-2"
  alias  = "west"
}

# Google Cloud Platform provider
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
```

### Module Required Providers

```hcl
# In each module, we declare the required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
```

### Multi-Provider Module Integration

```hcl
# AWS EKS Module
module "eks_cluster_east" {
  source = "../modules/eks-module"

  name_prefix = "dkb-east"
  environment = var.environment
  vpc_id      = aws_vpc.east.id
  subnet_ids  = aws_subnet.east_public[*].id

  providers = {
    aws = aws.east
  }
}

# GCP Infrastructure Module
module "gcp_infrastructure" {
  source = "../modules/gcp-module"

  name_prefix = var.name_prefix
  environment = var.environment
  region      = var.gcp_region
  node_count  = var.gcp_node_count
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

This implementation demonstrates how to effectively use multiple providers in Terraform to deploy resources across different cloud platforms and regions. The approach ensures that:

1. Resources are properly isolated between cloud providers and regions
2. Provider-specific configurations are applied where needed
3. Resource naming and tagging is consistent and clear
4. Modules can be reused across providers with proper configuration

Key advantages of this approach:

- Multi-cloud flexibility and reduced vendor lock-in
- Improved disaster recovery capabilities
- Geographic distribution for lower latency
- Isolation of regional and provider-specific failures
- Consistent container orchestration across cloud providers
- Simplified multi-cloud management through code

## Additional Resources Used
- AWS Multi-Region Architecture Documentation
- Google Cloud Platform Documentation
- Terraform Provider Configuration Documentation
- HashiCorp Learn: Managing Multiple Providers
- Kubernetes Documentation
- Docker Documentation
- Amazon Q

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post] 

## Time Spent
- Reading: 1 hours
- Design: 3 hours
- Implementation: 5 hours
- Total: 9 hours

## Repository Structure

```
Day15/
   └── Submissions/
         └── David-Kamau-Builds/
               ├── modules/
               │   ├── blue-green-module/
               │   │   ├── main.tf
               │   │   ├── variables.tf
               │   │   ├── outputs.tf
               │   │   └── templates/
               │   │       └── user_data.sh.tpl
               │   ├── eks-module/
               │   │   ├── main.tf
               │   │   ├── variables.tf
               │   │   └── outputs.tf
               │   ├── gcp-module/
               │   │   ├── main.tf
               │   │   ├── variables.tf
               │   │   └── outputs.tf
               │   └── secrets-module/
               │       ├── main.tf
               │       ├── variables.tf
               │       └── outputs.tf
               ├── production/
               │   ├── main.tf
               │   ├── secrets.tf
               │   ├── provider.tf
               │   ├── variables.tf
               │   └── terraform.tfvars
               ├── .gitignore
               ├── day15-submission.md
               └── README.md
```