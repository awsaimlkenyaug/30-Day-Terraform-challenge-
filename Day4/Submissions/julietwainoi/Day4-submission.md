# Day 4 Submission

## Personal Information
- **Name:** Juliet Wanjiku
- **Date:** May 29 2025
- **GitHub Username:** julietwaioni

## Task Completion
- [ x ] Read Chapter 2 of "Terraform: Up & Running"
- [ x ] Completed Required Hands-on Labs
- [ x ] Deployed Single Server
- [ x ] Deployed Web Server
- [ x ] Created Infrastructure Diagrams

## Infrastructure Details

**Note:** PLEASE SEE THIS IN DAY THREE.
#### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Basic EC2 instance
  - Tagged with Name = "SingleServer"

#### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - EC2 with Apache Web Server
  - Displays simple HTML page
  - Uses `user_data` script for setup

---

### Infrastructure Diagrams
See images in the `architecture/` folder:
- `single-server.png`
- `web-server.png`

## Blog Post
- **Title:** Deploying a Highly Available Web App on AWS Using Terraform
- **Link:** https://julietwainoi.github.io/blog4.html

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://www.linkedin.com/in/juliet-wainoi/

## Notes and Observations
deploying the cluster instances needs an ELB.

## Additional Resources Used
TerraFORM documentation

## Time Spent
- Reading: 2 hours
- Infrastructure Deployment: 2hours
- Diagram Creation: 0.5 hours
- Blog Writing: 1 hours
- Total: 5.5 hours

## Repository Structure
```
Day4/
└── Submissions/
    └── julietwaioni
        ├── configurable-cluster-webserver/
        │   ├── single-server.png
        │   └── main.tf
        ├── Day4-submission
  




