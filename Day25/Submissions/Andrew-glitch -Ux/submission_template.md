# Day 25 Submission

## Personal Information
- **Name:** [Andrew-glitch-Ux]
- **Date:** [28-06-2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [X] Deploy a static website on **AWS S3** using **Terraform**
- [x] Completed Required Hands-on Labs
- [X] integrateD s3 with **CloudFront** for secure global delivery
- [X] Created Infrastructure Diagrams

## Infrastructure Details

## 🧱 Infrastructure Used Today

- **AWS S3** – static website hosting (index + error pages)
- **AWS CloudFront** – HTTPS CDN distribution
- **Terraform Modules** – reusable code for S3 + CloudFront
- **Remote State Backend** – S3 bucket with DynamoDB locking
- **Environment-Based Setup** – using `envs/dev/` for isolated configs
- **Outputs & Inter-Module Wiring** – connected modules via output variables
- **Tags, Variables, tfvars** – clean structure and configurable inputs

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** [Your Blog Post Title]
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** [LinkedIn]
- **Post Link:** [https://www.linkedin.com/feed/update/urn:li:activity:7344795467748151298/ ]

## Notes and Observations
[How **Terraform modules** promote clean, DRY, and testable code
- The role of **remote state** and how to manage it securely
- Difference between regular S3 buckets vs. website-enabled ones
- How CloudFront works with S3 to deliver static content globally with HTTPS]

## Additional Resources Used
[List any additional resources you found helpful]

## Time Spent
- Infrastructure Deployment: [2 hours]
- Diagram Creation: [1/2 Hours]
- Blog Writing: [1/2 hours]
- Total: [3 hours]

## Repository Structure
```
Day25/
└── Submissions/
    └── [Andrew-glitch-Ux]/
        ├── Architecture/
        │   ├── day 25.drawio.png
        ├── envs/
            └── dev/
                ├──.terraform/
            │ │ └── modules/
            │ │ │ ├── modules.json
            │ │ └── providers/
            │ │ │ ├── LICENSE.txt
            │ │ │ └── terraform-provider-aws_v5.100.0_x5.exe
                ├──.terraform.lock.hcl
            │   ├── main.tf
                ├── output.tf
                ├── variables.tf
            │   ├── terraform.tfstate
                ├──terraform.tfstate
            │   └── terraform.tfvars
        ├── modules/
            └── s3-static-website/
                ├── main.tf
            │   ├── variables.tf
            │   └── outputs.tf
           cloudfront-static-site/
                ├── main.tf
            │   ├── variables.tf
            │   └── outputs.tf
        ├── backend.tf
        ├── provider.tf
        └── variables.tf
        └──  daily update.md
        └── submission.md
    ├──README.md
    ├──submission_template.md
├──README.md
├──tasks.md
``` 




