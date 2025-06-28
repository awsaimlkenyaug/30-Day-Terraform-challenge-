# Day 20 Submission

## Personal Information

- **Name:** David Washington Kamau Kibe
- **Date:** June 21, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion

- [x] Read Chapter 10 section "A Workflow for Deploying Application Code"
- [x] Completed required hands-on labs (Lab 21 and Lab 22)
- [x] Completed Lab 21: Terraform Enterprise
- [x] Completed Lab 22: Sentinel Policies
- [x] Simulated workflow for deploying application code following the 7-step process
- [x] Secured sensitive variables in Terraform Cloud
- [x] Integrated version control system (GitHub) with Terraform Cloud
- [x] Explored private registry feature in Terraform Cloud

## Infrastructure Details

### 7-Step Deployment Workflow

1. **Version Control Integration**

   - Connected GitHub repository to Terraform Cloud workspace
   - Configured automatic triggering on code changes
   - Set up branch-based deployment strategies

2. **Environment Management**

   - Development, staging, and production workspaces
   - Environment-specific variable sets
   - Workspace-to-workspace data sharing

3. **Secure Variable Management**

   - Sensitive variables stored in Terraform Cloud
   - Environment variables for API keys and secrets
   - Terraform variables for configuration parameters

4. **Automated Planning**

   - Automatic plan generation on pull requests
   - Plan review and approval workflow
   - Integration with GitHub status checks

5. **Controlled Apply Process**

   - Manual approval gates for production deployments
   - Automated applies for development environments
   - Run notifications and status updates

6. **State Management**

   - Remote state storage in Terraform Cloud
   - State locking and versioning
   - Workspace isolation for different environments

7. **Monitoring and Rollback**
   - Deployment status monitoring
   - Quick rollback capabilities
   - Audit logs and compliance tracking

## Technical Implementation

### Terraform Cloud Configuration

```hcl
terraform {
  cloud {
    organization = "david-kamau-builds"

    workspaces {
      name = "day21-app-deployment"
    }
  }
}
```

### Variable Management

```hcl
# Sensitive variables configured in Terraform Cloud UI
variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```

### GitHub Integration

```yaml
# .github/workflows/deploy.yml
name: Terraform Deploy
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          cli_config_credentials_token: ${{ secrets.TF_API_TOKEN }}
      - name: Terraform Plan
        run: terraform plan
```

### Private Registry Module

```hcl
module "web_application" {
  source  = "app.terraform.io/david-kamau-builds/web-app/aws"
  version = "~> 1.0"

  environment     = var.environment
  instance_type   = var.instance_type
  vpc_cidr        = var.vpc_cidr

  providers = {
    aws = aws
  }
}
```

## Sentinel Policies Implementation

### Cost Control Policy

```hcl
# sentinel/cost-control.sentinel
import "tfplan/v2" as tfplan
import "decimal"

# Calculate total monthly cost
monthly_cost = decimal.new(0)

for tfplan.resource_changes as _, rc {
    if rc.change.actions contains "create" {
        if rc.type is "aws_instance" {
            monthly_cost = decimal.add(monthly_cost, decimal.new(50))
        }
    }
}

# Enforce cost limit
main = rule {
    decimal.less_than(monthly_cost, decimal.new(500))
}
```

### Security Policy

```hcl
# sentinel/security-policy.sentinel
import "tfplan/v2" as tfplan

# Ensure all S3 buckets are encrypted
s3_buckets_encrypted = rule {
    all tfplan.resource_changes as _, rc {
        if rc.type is "aws_s3_bucket" {
            rc.change.after.server_side_encryption_configuration is not null
        } else {
            true
        }
    }
}

main = rule {
    s3_buckets_encrypted
}
```

## Notes and Observations

This implementation demonstrates a complete workflow for deploying application code using Terraform Cloud:

1. **Automation Benefits:**

   - Reduced manual errors through automated planning and applying
   - Consistent deployments across environments
   - Integrated approval workflows for production changes

2. **Security Enhancements:**

   - Centralized secret management in Terraform Cloud
   - Policy-as-code enforcement with Sentinel
   - Audit trails for all infrastructure changes

3. **Collaboration Features:**
   - Team-based access controls and permissions
   - Shared module registry for code reuse
   - Integration with existing development workflows

Key advantages of this approach:

- Streamlined deployment process from development to production
- Enhanced security through centralized variable management
- Policy enforcement to prevent configuration drift
- Improved collaboration through shared modules and workspaces
- Complete audit trail for compliance requirements

## Additional Resources Used

- Terraform: Up & Running Chapter 10
- Terraform Cloud Documentation
- Sentinel Policy Language Documentation
- GitHub Actions Integration Guide
- Amazon Q

## Blog Post

- **Title:** A Workflow for Deploying Application Code with Terraform
- **Link:** [URL to your blog post]

## Social Media

- **Platform:** Twitter/LinkedIn
- **Post Link:** [URL to your social media post]

## Time Spent

- Reading: 2 hours
- Implementation: 1 hours
- Documentation: 1 hour
- Total: 4 hours

## Repository Structure

```
day21/
   └── David-Kamau-Builds/
         ├── .github/
         │   └── workflows/
         │       ├── deploy.yml
         │       └── destroy.yml
         ├── David-Kamau-Builds/
         │   └── Work-flow/
         │       ├── application/
         │       │   ├── package.json
         │       │   ├── server.js
         │       │   └── server.test.js
         │       └── terraform/
         │           ├── main.tf
         │           ├── provider.tf
         │           ├── variables.tf
         │           ├── outputs.tf
         │           ├── terraform-cloud.tf
         │           └── versions.tf
         ├── docs/
         │   ├── infra.dot
         │   └── infra.svg
         ├── Images/
         │   ├── Image1.png
         │   ├── Image2.png
         │   ├── Image3.png
         │   ├── Image4.png
         │   ├── Image5.png
         │   ├── Image6.png
         │   └── Image7.png
         ├── .gitignore
         ├── PROJECT_GUIDE.md
         ├── README.md
         └── day21-submission.md
```
