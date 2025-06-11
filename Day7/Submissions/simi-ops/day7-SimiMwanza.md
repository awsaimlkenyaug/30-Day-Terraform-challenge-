# Day 7 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 3rd June 2025
- **GitHub Username:** simi-ops

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [ ] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Web Server Deployment
- **Region:** us-west-2
- **Instance Type:** t2-micro
- **Key Features:** S3 bucket and DynamoDB table for state file and locking

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** State Isolation: Layout vs Workspace
- **Link:** https://simiops.hashnode.dev/state-isolation-layout-vs-workspace

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1931339591253975318

## Notes and Observations
- Set up my dynamodb table to store state lock files
- Also set up workspaces
## Additional Resources Used


## Time Spent
- Reading: [1 hours]
- Infrastructure Deployment: [1 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [1 hours]
- Total: [4 hours]

## Repository Structure
```
Day7/
└── Submissions/
    └── simi-ops/
        ├── architecture/
        │   └── web-server.png
        ├── terraform/
        │   └── web-server/
        │   |   ├── main.tf
        |   |   ├── variable.tf
        |   |   └── backend.tf
            |____dev/
            │       ├── main.tf
            |       ├── variable.tf
            |       └── backend.tf 
            |   prod/ 
            │       ├── main.tf
            |       ├── variable.tf
            |       └── backend.tf 
        └── day7-SimiMwanza.md
``` 



