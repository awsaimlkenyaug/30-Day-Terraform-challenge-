# Day 17 Submission

## Personal Information
- **Name:** David Washington Kamau Kibe
- **Date:** June 12, 2025
- **GitHub Username:** David-Kamau-Builds

## Task Completion
- [x] Completed Chapter 9 sections on Manual Testing
- [x] Completed required hands-on labs (Lab 18 and Lab 19)
- [x] Performed manual tests on existing Terraform configurations
- [x] Verified resources are created correctly and behave as expected
- [x] Checked for regressions introduced by changes
- [x] Documented issues encountered and their resolutions
- [x] Cleaned up environment after testing to avoid unnecessary costs
- [x] Created comprehensive testing documentation

## Testing Details

### Manual Testing Approach

- **Configuration Tested:** Web Server Infrastructure with Auto Scaling
- **Testing Environment:** AWS us-east-1 region
- **Testing Method:** Systematic verification of resources and functionality
- **Documentation:** Created detailed testing plan, results, and cleanup checklist

### Key Components Tested

1. **Pre-Deployment Validation:**
   - Terraform configuration validation
   - Code formatting verification
   - Plan review for expected changes

2. **Resource Creation Testing:**
   - VPC and networking components
   - Security groups and access controls
   - Load balancer configuration
   - Auto scaling group setup
   - Key pair creation from public key

3. **Functionality Testing:**
   - Web application accessibility via ALB
   - SSH access using created key pair
   - Auto scaling functionality
   - CloudWatch alarms and scaling policies

4. **Regression Testing:**
   - Modified instance type and verified changes
   - Adjusted capacity settings and confirmed scaling
   - Reverted changes and verified return to original state

## Technical Implementation

### Testing Documentation

I created three key documents to structure the manual testing process:

1. **Manual Testing Plan:**
```markdown
# Manual Testing Plan for Web Server Infrastructure

## Pre-Deployment Checks
- Run terraform validate to check for syntax errors
- Run terraform fmt -check to verify formatting
- Run terraform plan to preview changes

## Deployment Testing
- Run terraform apply and confirm all resources are created
- Verify resources in AWS Console
- Test functionality of deployed application

## Regression Testing
- Make controlled changes and verify expected behavior
- Revert changes and confirm system returns to original state

## Cleanup Procedure
- Run terraform destroy to remove all resources
- Verify in AWS Console that all resources are properly removed
```

2. **Testing Results Document:**
```markdown
# Web Server Infrastructure Testing Results

## Issues Encountered and Resolutions

1. **Issue**: Dynamic tag block syntax error
   - **Description**: The ASG configuration used each.key incorrectly
   - **Resolution**: Updated to use tag.key and tag.value instead

2. **Issue**: SSH access initially failed
   - **Description**: Security group allowed SSH from placeholder IP
   - **Resolution**: Updated terraform.tfvars with correct IP address
```

## Issues and Resolutions

During testing, I encountered and resolved the following issues:

1. **Dynamic Tag Block Error**
   - **Issue:** The Auto Scaling Group configuration used incorrect syntax in the dynamic tag block
   - **Resolution:** Updated the code to use `tag.key` and `tag.value` instead of `each.key` and `each.value`
   - **Prevention:** Added validation step to check dynamic blocks before deployment

2. **SSH Access Configuration**
   - **Issue:** Security group allowed SSH from placeholder IP instead of actual IP
   - **Resolution:** Updated terraform.tfvars with the correct IP address (197.248.131.121/32)
   - **Prevention:** Created documentation on proper variable configuration

3. **Key Pair Management**
   - **Issue:** Key pair was referenced but not created in the configuration
   - **Resolution:** Added aws_key_pair resource to create the key pair from public key file
   - **Prevention:** Implemented checklist for required resources

## Notes and Observations

This manual testing exercise demonstrated several important principles:

1. **Importance of Pre-Deployment Validation:**
   - Terraform validate and plan caught several issues before deployment
   - Format checking ensured consistent code style

2. **Systematic Resource Verification:**
   - Checking each resource in the AWS Console confirmed proper creation
   - Verifying resource relationships ensured correct infrastructure setup

3. **Functional Testing Value:**
   - Testing the actual application functionality revealed issues not apparent in the configuration
   - SSH access testing confirmed security configurations were correct

4. **Cleanup Importance:**
   - Thorough cleanup prevented unnecessary costs
   - Verification of resource deletion prevented orphaned resources

## Additional Resources Used
- Terraform Manual Testing Documentation
- AWS Console for resource verification
- SSH client for connectivity testing
- Web browser for application testing
- Amazon Q for troubleshooting assistance

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post] 

## Time Spent
- Reading: 1 hour
- Testing Implementation: 2 hours
- Documentation: 1 hour
- Issue Resolution: 30 minutes
- Total: 4 hours

## Repository Structure

```
Day17/
   └── Submission/
         └── David-Kamau-Builds/
           │   ├── architecture/
           │   │   ├── single-server-application-architecture.png
           │   │   └── web-server-application-architecture.png
           │   ├── terraform/
           │   │   ├── single-server/
           │   │   │   ├── id_rsa.pub
           │   │   │   ├── main.tf
           │   │   │   ├── outputs.tf
           │   │   │   ├── provider.tf
           │   │   │   ├── README.MD
           │   │   │   ├── terraform.tfvars
           │   │   │   ├── variables.tf
           │   │   │   └── versions.tf
           │   └── web-server/
           │       ├── cleanup_checklist.md
           │       ├── id_rsa.pub
           │       ├── main.tf
           │       ├── manual_testing_plan.md
           │       ├── outputs.tf
           │       ├── provider.tf
           │       ├── README.MD
           │       ├── terraform.tfvars
           │       ├── testing_results.md
           │       ├── variables.tf
           │       └── versions.tf
           ├── .gitignore
           └── day17-submission.md