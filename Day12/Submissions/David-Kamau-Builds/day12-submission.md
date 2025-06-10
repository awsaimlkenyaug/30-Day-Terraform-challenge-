# Day 12 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 7, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [ ] Read Chapter 5 of "Terraform: Up & Running" (Pages 169-189)
- [x] Completed Required Hands-on Labs
- [x] Implemented zero-downtime deployment infrastructure
- [x] Created blue/green deployment strategy
- [x] Set up Application Load Balancer for traffic routing
- [x] Implemented auto-scaling groups for both environments
- [x] Added canary release capability with header-based routing

## Infrastructure Details

### Blue/Green Deployment Architecture

- **Module:** blue-green-module
- **Region:** us-east-1
- **Key Components:**
  - Application Load Balancer
  - Blue and Green target groups
  - Blue and Green auto-scaling groups
  - Traffic switching mechanism

### Zero-Downtime Strategy

The implementation uses a blue/green deployment strategy with the following workflow:

1. Two identical environments (blue and green) are maintained
2. Only one environment is active at any time (controlled by `active_deployment` variable)
3. New versions are deployed to the inactive environment
4. Traffic is switched by changing a single parameter
5. Automatic scaling of environments based on active status

### Canary Testing

- Header-based routing allows testing the new version before full deployment
- Requests with `X-Environment: test` header are routed to the inactive environment
- Enables validation of new versions without affecting production traffic

## Technical Implementation

### Load Balancer Configuration

- Application Load Balancer with HTTP listener
- Target groups for blue and green environments
- Listener rules for default and test traffic

### Auto-Scaling Groups

- Separate ASGs for blue and green environments
- Dynamic scaling based on active deployment status
- Automatic registration with appropriate target groups

### Launch Templates

- Customized user data for each environment
- Security hardening with IMDSv2 requirement
- EBS volume encryption
- Version tagging for tracking deployments


## Notes and Observations

This implementation demonstrates how to achieve zero-downtime deployments using Terraform. The blue/green deployment strategy allows for safe updates to web applications without service interruption.

Key advantages of this approach:

- Complete isolation between production and staging environments
- Simple parameter-based traffic switching
- Ability to test new versions before full deployment
- Easy rollback procedure if issues are detected
- Automatic scaling based on deployment status

## Additional Resources Used
- Terraform Documentation
- Amazon Q

## Blog Post
- **Title:** Zero-Downtime Deployments with Terraform: A Blue-Green Approach
- **Link:** https://medium.com/@davidwashingtonkamau/zero-downtime-deployments-with-terraform-a-blue-green-approach-74618fe475fc

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post]

## Time Spent

- Design: 1 hour
- Implementation: 3 hours
- Testing: 1 hour
- Total: 5 hours

## Repository Structure

```
Day12/
└── Submission/
    └── David-Kamau-Builds/
        ├── modules/
        │   ├── blue-green-module/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── outputs.tf
        ├── production/
        │   ├── main.tf
        │   ├── variables.tf
        │   └── terraform.tfvars
        └── day12-submission.md

```

