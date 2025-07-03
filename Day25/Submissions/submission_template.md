# Day 25 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-30
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

### Static Website Deployment
- **Region:** us-east-1
- **Key Features:**
  - S3 bucket configured for static website hosting
  - Public access via bucket policy using `BucketOwnerEnforced`
  - Remote state stored in a separate S3 bucket with DynamoDB for locking
  - Modularized Terraform code for reuse

## Infrastructure Diagrams
- `architecture/day25-s3-cloudfront.png` - Shows user → CloudFront → S3

## Blog Post
- **Title:** Deploying a Static Website on AWS S3 with Terraform: A Beginner’s Guide
- **Link:** https://medium.com/@ngumonelson123/terraform-static-site-day25

## Social Media
- **Platform:** LinkedIn
- **Post Link:** https://linkedin.com/in/ngumonelson123

## Notes and Observations
- Faced ACL error due to AWS ObjectOwnership — resolved by removing `acl` and using `BucketOwnerEnforced`
- Learned the power of reusable modules and secure public access
- Remote state best practices are crucial for team collaboration

## Additional Resources Used
- HashiCorp Docs
- AWS S3 Static Website Hosting Docs
- Terraform Registry

## Time Spent
- Reading: 1 hour
- Infrastructure Deployment: 2 hours
- Diagram Creation: 0.5 hour
- Blog Writing: 1.5 hours
- Total: 5 hours

## Repository Structure
Day25/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ └── day25-s3-cloudfront.png
├── modules/
│ └── s3-static-website/
├── envs/
│ └── dev/
└── submission.md