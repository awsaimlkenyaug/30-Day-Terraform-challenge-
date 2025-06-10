# Terraform Blocks Comparison Table
*Day 5: Understanding Terraform State & Infrastructure Components*

## Overview
This document provides a comprehensive comparison of different Terraform block types, their purposes, and usage patterns. Understanding these blocks is crucial for effective Infrastructure as Code (IaC) management.

## Main Terraform Blocks Comparison

| Block Type | Purpose | Scope | Required/Optional | Example Usage |
|------------|---------|-------|-------------------|---------------|
| **terraform** | Configure Terraform behavior, versions, backends | Global configuration | Optional but recommended | Version constraints, remote state |
| **provider** | Configure cloud/service providers | Provider-specific | Required for resources | AWS, Azure, GCP configuration |
| **resource** | Define infrastructure components | Individual resources | Required for infrastructure | EC2 instances, S3 buckets |
| **data** | Fetch existing infrastructure info | Read-only queries | Optional | Existing VPCs, AMIs |
| **variable** | Input parameters for configuration | Module/configuration scope | Optional | Instance types, regions |
| **output** | Export values from configuration | Module/configuration scope | Optional | IP addresses, DNS names |
| **locals** | Define local computed values | Local scope | Optional | Tags, computed names |
| **module** | Reusable infrastructure components | Module scope | Optional | VPC module, web server cluster |

## Detailed Block Analysis

### 1. Terraform Block
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "infrastructure/terraform.tfstate"
    region = "us-east-1"
  }
}
```

**Key Features:**
- Sets Terraform version constraints
- Defines required providers
- Configures remote state backends
- Global configuration for the entire configuration

### 2. Provider Block
```hcl
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project = "terraform-learning"
      Owner   = "team"
    }
  }
}
```

**Key Features:**
- Configures authentication and settings
- Can have multiple instances (aliases)
- Provider-specific configuration options
- Default tags and global settings

### 3. Resource Block
```hcl
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  tags = {
    Name = "WebServer-${var.environment}"
  }
}
```

**Key Features:**
- Creates and manages infrastructure
- Has lifecycle management (create, update, delete)
- Supports dependencies and references
- Can have count or for_each for multiple instances

### 4. Data Block
```hcl
data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}
```

**Key Features:**
- Read-only access to existing resources
- Queries external systems
- Provides information for resource configuration
- Refreshed on each plan/apply

### 5. Variable Block
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
  
  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium"
    ], var.instance_type)
    error_message = "Instance type must be t3.micro, t3.small, or t3.medium."
  }
}
```

**Key Features:**
- Input parameters for configurations
- Type validation and constraints
- Default values and descriptions
- Sensitive flag for security

### 6. Output Block
```hcl
output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
  sensitive   = false
}
```

**Key Features:**
- Exports values from configuration
- Can be marked as sensitive
- Used by other configurations or modules
- Displayed after terraform apply

### 7. Locals Block
```hcl
locals {
  common_tags = {
    Project     = "terraform-learning"
    Environment = var.environment
    CreatedBy   = "Terraform"
  }
  
  cluster_name = "${var.environment}-web-cluster"
  
  instance_config = {
    type = var.instance_type
    ami  = data.aws_ami.amazon_linux.id
  }
}
```

**Key Features:**
- Computed values within configuration
- Reduces repetition and improves maintainability
- Can reference other locals, variables, and resources
- Local scope only

### 8. Module Block
```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  
  tags = local.common_tags
}
```

**Key Features:**
- Reusable infrastructure components
- Encapsulation and abstraction
- Version control and source management
- Input variables and output values

## State Management Considerations

### Local State vs Remote State

| Aspect | Local State | Remote State |
|--------|-------------|--------------|
| **Storage** | Local filesystem (.terraform.tfstate) | Remote backend (S3, Azure, GCP) |
| **Collaboration** | Single user only | Multi-user collaboration |
| **Security** | Local file security | Encrypted, access-controlled |
| **Backup** | Manual backup needed | Automatic versioning/backup |
| **Locking** | No concurrent protection | State locking available |
| **Best For** | Learning, development | Production, team environments |

### State File Structure
```json
{
  "version": 4,
  "terraform_version": "1.5.0",
  "serial": 1,
  "lineage": "unique-id",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web_server",
      "provider": "provider.aws",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "id": "i-1234567890abcdef0",
            "ami": "ami-12345678",
            "instance_type": "t3.micro"
          }
        }
      ]
    }
  ]
}
```

## Best Practices Summary

### Block Organization
1. **terraform** block at the top
2. **provider** blocks next
3. **data** blocks for external references
4. **locals** for computed values
5. **resources** grouped logically
6. **variables** and **outputs** at end or separate files

### State Management
1. Always use remote state for production
2. Enable state locking
3. Use versioning for state files
4. Regular state backups
5. Never edit state files manually

### Security Considerations
1. Mark sensitive variables and outputs
2. Use secure backends (encrypted)
3. Implement proper access controls
4. Avoid hardcoding secrets
5. Use separate state files for different environments

## Day 5 Implementation Example

In our Day 5 enhanced load balancer implementation, we used:

- **terraform** block: Version constraints and future remote state configuration
- **provider** block: AWS provider with default tags
- **data** blocks: VPC, subnets, AMI discovery
- **resource** blocks: ALB, ASG, security groups, CloudWatch alarms
- **variable** blocks: 40+ configurable parameters with validation
- **output** blocks: 25+ outputs for monitoring and connectivity
- **locals** block: Common tags and computed configurations

This demonstrates how different block types work together to create a comprehensive, maintainable infrastructure configuration.
