# Day 6 Submission

## Personal Information
- **Name:** Andrew Muntet
- **Date:** 6/6/2025
- **GitHub Username:** Andrew-glitch-Ux

## Task Completion
- [x] Completed Lab 07: Outputs and Resource References
- [x] Completed Lab 08: State Management with Local and Remote Backends
- [x] Created Infrastructure Diagrams for Lab 07 and Lab 08

## Infrastructure Details

### Lab 07: Outputs and Resource References
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:** Deployed EC2 instance with defined outputs for instance ID, public IP, and DNS. Fixed resource referencing errors by correctly declaring AWS instance resource.

### Lab 08: State Management
- **Region:** eu-north-1
- **Key Features:** Created an S3 bucket resource using Terraform, initially using local state, then configured and migrated state to remote backend using pre-existing S3 bucket (`andrew-tf-lab08-bucket`) and DynamoDB table (`andrew-tf-lab08-lock`). Validated state storage remotely.

## Infrastructure Diagrams
Infrastructure diagrams for both labs are saved in the `architecture` folder:
- `lab07.drawio.png` — Diagram illustrating the EC2 instance and output configurations from Lab 07
- `lab08.drawio.png` — Diagram illustrating S3 bucket provisioning and remote backend state management setup from Lab 08

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [Twitter/LinkedIn]
- **Post Link:** [URL to your social media post]

## Notes and Observations
- I learned how Terraform outputs allow sharing resource information easily.
- Managing state remotely with S3 and DynamoDB locking helps avoid conflicts in team environments.
- Migrating local state to remote backend is a smooth process when configured correctly.
- Proper resource declaration is crucial to avoid errors referencing undeclared resources.
- Understanding backend configuration deepens my grasp of Terraform’s infrastructure management.

## Additional Resources Used
- Official Terraform documentation on state management
- AWS Console for validating S3 and DynamoDB resources
- Draw.io for infrastructure diagramming

## Time Spent
- Reading & Study: 1.5 hours
- Lab 07 Infrastructure Deployment & Debugging: 2 hours
- Lab 08 State Management Setup & Validation: 2 hours
- Infrastructure Diagrams: 0.5 hours
- Blog Writing & Documentation: 1 hour
- **Total:** 7 hours

## Repository Structure

```
Day6/
└── Submissions/
└── Andrew-glitch-Ux/
├── architecture/
│ ├── lab07.drawio.png
│ └── lab08.drawio.png
├── Lab 07/
│ ├── .terraform/
│ │ ├── LICENSE.txt
│ │ └── terraform-provider-aws_v5.99.1_x5.exe
│ ├── .terraform.lock.hcl
│ ├── main.tf
│ ├── outputs.tf
│ ├── terraform.tfstate
│ └── variables.tf
├── Lab 08/
│ ├── .terraform/
│ │ ├── LICENSE.txt
│ │ └── terraform-provider-aws_v5.99.1_x5.exe
│ ├── .terraform.lock.hcl
│ ├── backend.tf
│ ├── main.tf
│ ├── outputs.tf
│ └── variables.tf
├── daily_update.md
├── submission_day6.md
└── README.md
README.md
tasks.md

```