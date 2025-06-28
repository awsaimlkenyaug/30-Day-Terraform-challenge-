# Manual Testing Plan for Web Server Infrastructure

## Pre-Deployment Checks

1. **Configuration Validation**
   - Run `terraform validate` to check for syntax errors
   - Run `terraform fmt -check` to verify formatting
   - Run `terraform plan` to preview changes

## Deployment Testing

1. **Resource Creation**
   - Run `terraform apply` and confirm all resources are created successfully
   - Verify no errors in the Terraform output

2. **Infrastructure Verification**
   - Check AWS Console to confirm all resources exist:
     - VPC with correct CIDR block
     - Internet Gateway attached to VPC
     - Two public subnets in different AZs
     - Route table with routes to IGW
     - Security groups with correct rules
     - ALB with proper configuration
     - Auto Scaling Group with 2 instances
     - Key pair created correctly

3. **Functionality Testing**
   - Access the ALB DNS name in a browser to verify the web page loads
   - SSH into an instance using the key pair to verify connectivity
   - Test auto scaling by increasing load (optional)

## Regression Testing

1. **Make a Small Change**
   - Modify instance type or desired capacity
   - Run `terraform plan` to verify only intended resources are changed
   - Apply changes and verify they work as expected

2. **Revert Changes**
   - Restore original configuration
   - Verify system returns to original state

## Issue Documentation

| Issue | Description | Resolution |
|-------|-------------|------------|
| Dynamic tag block error | The dynamic tag block in ASG used `each.key` instead of `tag.key` | Fixed by changing to `tag.key` and `tag.value` |
| | | |

## Cleanup Procedure

1. **Resource Destruction**
   - Run `terraform destroy` to remove all resources
   - Verify in AWS Console that all resources are properly removed

2. **Local Cleanup**
   - Remove any sensitive files (keys, credentials)
   - Commit only non-sensitive files to version control

## Cost Considerations

- Estimated hourly cost of this infrastructure: ~$0.10-0.15/hour
- Maximum test duration recommendation: 2 hours
- Potential monthly cost if left running: ~$75-110