# Day 15 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** 2025-06-24
- **GitHub Username:** Denisganga

## Task Completion
- [x] Completed Chapter 7 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs (Lab 16 & Lab 17)
- [x] Created Multi-Provider Terraform Modules (AWS + GCP)
- [x] Deployed EC2 on AWS and Compute VM on GCP using modules
- [x] Deployed Docker containers using EKS with Terraform
- [x] Wrote a technical blog post on multi-cloud infrastructure with Terraform
- [x] Shared on social media

## Infrastructure Details

### Multi-Provider Module Deployment
- **Providers Used:** AWS, Google Cloud
- **AWS Region:** `us-east-1`
- **GCP Region:** `us-central1`
- **Resources Deployed:**
  - AWS EC2 instance via module (`t2.micro`)
  - GCP Compute Engine instance via module (`f1-micro`)
- **Key Features:**
  - Modular code with provider aliasing
  - Terraform-managed multi-cloud deployment
  - Clean variable and provider structure with `.tfvars` usage

### Docker & Kubernetes Deployment with EKS
- **Tool Used:** Terraform AWS EKS Module
- **Cluster Name:** `denis-eks-cluster`
- **Kubernetes Version:** `1.29`
- **Instance Type:** `t3.medium`
- **Deployment:** Docker containers orchestrated via EKS
- **Key Features:**
  - VPC created using AWS VPC module
  - Public/private subnets
  - IAM and node group setup
  - Connected using `aws eks update-kubeconfig` and verified with `kubectl get nodes`

## Blog Post
- **Title:** Deploying Multi-Cloud Infrastructure with Terraform Modules
- **Link:** [Add your blog post link here]

## Social Media
- **Platform:** Twitter
- **Post Text:** 🌐 Deployed multi-cloud infrastructure using Terraform today, including Docker and Kubernetes—taking my Terraform skills to the next level! #30daytfchallenge #HUG #hashicorp #HUGYDE @Chi Che. #IaC #terraform
- **Post Link:** [Add your tweet/post link here]

## Notes and Observations
- Got deep understanding of provider aliasing and modular Terraform.
- Faced provider configuration errors which were fixed by restructuring modules and cleaning state.
- Learned to structure EKS deployment from scratch using official AWS modules.
- Realized the power of modules in multi-cloud infrastructure as code.

## Additional Resources Used
- Terraform AWS Modules documentation
- "Terraform: Up & Running" Chapter 7
- AWS and GCP console docs
- GitHub Terraform examples
- Terraform Registry

## Time Spent
- Reading: 2.5 hours
- Infrastructure Deployment: 3.5 hours
- Blog Writing: 1.5 hours
- Total: 7.5 hours

## Repository Structure
```bash
Day15/
└── Submissions/
    └── Denisganga/
        ├── terraform/
        │   ├── multi-cloud/
        │   │   ├── main.tf
        │   │   ├── providers.tf
        │   │   ├── variables.tf
        │   │   ├── terraform.tfvars
        │   │   └── modules/
        │   │       ├── aws_vm/
        │   │       │   └── main.tf
        │   │       └── gcp_vm/
        │   │           └── main.tf
        │   └── eks-deployment/
        │       ├── main.tf
        │       ├── variables.tf
        │       ├── outputs.tf
        │       └── provider.tf
        └── submission.md
