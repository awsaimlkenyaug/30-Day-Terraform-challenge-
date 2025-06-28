# Infrastructure Cleanup Checklist

## AWS Resources to Verify Deletion

- [x] EC2 Instances
- [x] Auto Scaling Group
- [x] Launch Template
- [x] Application Load Balancer
- [x] Target Group
- [x] Security Groups
- [x] Route Tables
- [x] Subnets
- [x] Internet Gateway
- [x] VPC
- [x] CloudWatch Alarms
- [x] Key Pair

## Cleanup Commands

```bash
# Destroy all resources
terraform destroy -auto-approve

# Verify no state remains
terraform state list

# Remove any sensitive files
rm -f id_rsa*
```

## Cost Verification

- [x] Check AWS Billing Dashboard for any lingering costs
- [x] Verify no resources appear in AWS Cost Explorer

## Local Environment Cleanup

- [x] Remove or secure any credentials files
- [x] Remove .terraform directory
- [x] Keep terraform.tfstate.backup for reference
- [x] Commit only non-sensitive files to version control

## Final Verification

- [x] AWS Console shows no resources from this project
- [x] No unexpected charges in billing
- [x] All sensitive information is secured or removed