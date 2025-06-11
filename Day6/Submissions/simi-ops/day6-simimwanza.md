# Day 6 Submission

## Personal Information
- **Name:** Simi Mwanza
- **Date:** 2nd June 2025
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
- **Key Features:** Added a Load Balancer, and an S3 bucket to store the state file

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:

- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** How to Securely Store Terraform State Files with Remote Backends
- **Link:** https://simiops.hashnode.dev/managing-terraform-state-best-practices-for-devops

## Social Media
- **Platform:** Twitter
- **Post Link:** https://x.com/simi_mwanza/status/1931330863649767621

## Notes and Observations
- Deployed the state file to S3     
- Created an S3 bucket first using the command: 
`aws s3api create-bucket --bucket simi-ops-terraform-state \ 
    --region us-west-2 --create-bucket-configuration \
    LocationConstraint=us-west-2`

## Additional Resources Used
- https://docs.aws.amazon.com/cli/latest/reference/s3/mb.html

## Time Spent
- Reading: [1 hours]
- Infrastructure Deployment: [1 hours]
- Diagram Creation: [1 hours]
- Blog Writing: [2 hours]
- Total: [5 hours]

## Repository Structure
```
Day6/
└── Submissions/
    └── simi-ops/
        ├── architecture/
        │   └── web-server.png
        ├── terraform/
        │   └── web-server/
        │       ├── main.tf
        |       ├── variable.tf
        |       └── backend.tf        
        └── day6-SimiMwanza.md
``` 



