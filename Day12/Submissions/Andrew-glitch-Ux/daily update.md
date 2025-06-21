# Day 12 - Daily Update

## Date
11 June 2025

## What I Did Today
- Completed Lab 13: ASG + ALB deployment with basic scaling
- Completed Lab 14: Zero-Downtime Deployment using versioned Launch Templates
- Refactored security group to use variables instead of hardcoding
- Fixed module references, paths, and output errors
- Validated and applied infrastructure changes successfully
- Learned the significance of `user_data` updates on instance replacement
- Generated infra diagrams using draw.io

## What I Learned
- How to structure reusable Terraform modules with clean variable passing
- How ALB integrates with ASG and target groups
- How Launch Templates can version control instance configurations
- How to ensure smooth rollouts with no downtime using health checks
- The importance of consistent naming and referencing in module outputs

## Any Blockers
- Misreferenced outputs from modules caused validation errors initially
- Forgot to add `user_data.sh` in `asg` module, caused a failed templatefile call

## Time Spent
- Terraform Configuration: 2 hours
- Debugging Errors: 1 hour
- Diagramming: 30 minutes
