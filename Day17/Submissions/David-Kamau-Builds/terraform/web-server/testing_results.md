# Web Server Infrastructure Testing Results

## Test Date: [Current Date]

## Pre-Deployment Checks

- ✅ `terraform validate` - Passed
- ✅ `terraform fmt` - Passed
- ✅ `terraform plan` - Identified expected resource creation

## Deployment Results

### Resources Created Successfully:
- ✅ VPC (webapp-vpc)
- ✅ Internet Gateway
- ✅ 2 Public Subnets
- ✅ Route Table with IGW route
- ✅ Security Groups (web-sg, alb-sg)
- ✅ Application Load Balancer
- ✅ Target Group
- ✅ Key Pair (david-key-pair)
- ✅ Launch Template
- ✅ Auto Scaling Group with 2 instances
- ✅ CloudWatch Alarms

### Functionality Verification:
- ✅ Web page accessible via ALB DNS
- ✅ SSH access successful using created key pair
- ✅ Auto scaling responds to load changes

## Issues Encountered and Resolutions

1. **Issue**: Dynamic tag block syntax error
   - **Description**: The ASG configuration used `each.key` and `each.value` incorrectly in the dynamic tag block
   - **Resolution**: Updated to use `tag.key` and `tag.value` instead
   - **Prevention**: Add a pre-commit hook to run `terraform validate` before commits

2. **Issue**: SSH access initially failed
   - **Description**: Security group allowed SSH from placeholder IP instead of actual IP
   - **Resolution**: Updated terraform.tfvars with correct IP address (197.248.131.121/32)
   - **Prevention**: Use environment variables or a CI/CD pipeline to inject correct values

## Regression Testing

- ✅ Changed instance type from t2.micro to t3.micro - worked as expected
- ✅ Increased desired capacity from 2 to 3 - third instance launched correctly
- ✅ Reverted changes - system returned to original state

## Cleanup Confirmation

- ✅ `terraform destroy` executed successfully
- ✅ Verified all resources removed from AWS Console
- ✅ Removed sensitive files from local directory

## Recommendations

1. Add automated tests for basic infrastructure validation
2. Implement a cost estimation step in the CI/CD pipeline
3. Create a separate testing environment with resource limits