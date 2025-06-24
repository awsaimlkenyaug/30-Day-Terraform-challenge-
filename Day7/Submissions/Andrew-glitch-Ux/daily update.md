```markdown
# Day 7 - Terraform Challenge Update

## Summary
Today, I completed Lab 08 and Lab 09 focusing on Terraform state management. I practiced setting up local and remote backends, migrated state files safely, and learned about state locking using DynamoDB to avoid concurrent apply issues.

## What I Learned
- How to configure local and remote Terraform backends.
- The process to migrate state from local files to an S3 bucket.
- Setting up DynamoDB for Terraform state locking.
- Simulating concurrent applies and handling state lock conflicts.
- Importance of declaring variables to avoid config warnings.

## Challenges
- Initially missed declaring a variable which caused warnings.
- Understanding the exact backend config syntax took a bit of trial and error.

## Next Steps
- Start Lab 10 focusing on Terraform Workspaces for environment isolation