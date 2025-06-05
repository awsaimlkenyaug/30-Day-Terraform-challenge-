# Day 3 Submission

## Personal Information
- **Name:** Zablon
- **Date:** 02-06-2025
- **GitHub Username:** [zablon-oigo](https://github.com/zablon-oigo)

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Security Group that allows inbound traffic

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:** Custom user script

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** How to Set Up a Single Web Server on AWS with Terraform
- **Link:** [How to Set Up a Single Web Server on AWS with Terraform](https://medium.com/@zablon-oigo/how-to-set-up-a-single-web-server-on-aws-with-terraform-d0971db9ba91)

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [LinkedIn](https://www.linkedin.com/posts/zablon-oigo_30daytfchallenge-hug-hashicorp-activity-7336319437379096576-TFr7?utm_source=share&utm_medium=member_desktop&rcm=ACoAADpqOqwBjFTtzGtUYa4fYatIdIjqmNvTU1c)

## Notes and Observations
- The web server failed to respond on port 8080 after deployment.
- Found that the user_data.sh script used with templatefile wasn't executed correctly. 
- Fixed it by verifying script syntax and ensuring correct path

## Additional Resources Used
[Terraform Docs](https://developer.hashicorp.com/terraform/docs)

## Time Spent
- Reading: 2 hrs
- Infrastructure Deployment: 2 min
- Diagram Creation: 10 min
- Blog Writing: 2 hrs
- Total: 4 hrs 12 min

## Repository Structure
```
Day3/
└── Submissions/
    └── [Zablon]/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   ├── main.tf
        │   │   ├── var.tf
        │   │   └── output.tf
        │   └── web-server/
        │       ├── main.tf
        │       ├── var.tf
        │       ├── output.tf
        │       └── user_data.sh
        └── submission.md

``` 



