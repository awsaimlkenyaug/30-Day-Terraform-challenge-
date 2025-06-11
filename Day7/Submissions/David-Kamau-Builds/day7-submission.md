# Day 7 Submission

## Personal Information
- **Name:** David Kamau
- **Date:** June 2, 2025
- **GitHub Username:** David-Kamau-BUilds

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Infrastructure with State Management
- [x] Implemented State Locking
- [x] Created State Isolation with Workspaces and File Layouts

## Infrastructure Details

### State Management
- **Region:** us-east-1
- **Resource Type:** S3 Bucket
- **Key Features:** Basic state management with local state file

### Remote State with Locking
- **Region:** us-east-1
- **Resource Type:** S3 Bucket with DynamoDB
- **Key Features:** Remote state storage, state locking with DynamoDB

### State Isolation Approaches
- **Workspaces Approach:**
  - Dynamic bucket naming based on workspace
  - Private ACL and versioning enabled
  
- **File Layout Approach:**
  - Separate directories for dev, testing, and production
  - Modular approach with reusable S3 bucket module

## Notes and Observations
- Successfully implemented remote state management using S3
- Fixed a deprecation warning by replacing `dynamodb_table` with `use_lock_file` in the backend configuration
- Demonstrated two approaches to state isolation: workspaces and file layouts
- Created reusable modules for infrastructure components

## Time Spent
- Reading: 1 hours
- Infrastructure Deployment: 3 hours
- Troubleshooting: 1 hour
- Total: 5 hours

## Repository Structure
```
David-Kamau-Builds/
├── remote_state/
│   └── main.tf
├── state-locking/
│   └── main.tf
├── state_isolation_workspaces/
│   └── main.tf
├── state_isolation_file_layouts/
│   ├── dev/
│   │   ├── backend.tf
│   │   └── main.tf
│   ├── modules/
│   │   └── s3bucket/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── production/
│   │   ├── backend.tf
│   │   └── main.tf
│   └── testing/
│       ├── backend.tf
│       └── main.tf
├── state_management/
│   └── main.tf
└── day7-submission.md
```