# Day 9 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-25
- **GitHub Username:** ngumonelson123

---

## Task Completion
- [x] Read Chapter 2 & Chapter 4 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

---

## Infrastructure Details

### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Custom VPC and subnet
  - Reusable Terraform module
  - Tags for Name and Environment
  - Output of instance ID and public IP

### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Apache web server installed via `user_data`
  - Accessible on port 80
  - Reusable module with environment-specific configuration
  - Deployed in isolated subnet within custom VPC

---

## Infrastructure Diagrams

Please see the `architecture` folder:
- ✅ `single-server.png` - Dev server EC2 instance inside private subnet
- ✅ `web-server.png` - Web server with Apache, security group allowing port 80 and 22

---

## Blog Post
- **Title:** Advanced Terraform Module Usage: Versioning, Nesting, and Reuse Across Environments
- **Link:** [https://medium.com/@ngumonelson123/advanced-terraform-module-versioning](https://medium.com/@ngumonelson123/advanced-terraform-module-versioning)

---

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://www.linkedin.com/posts/ngumonelson123_terraform-infrastructure-iac-activity-abcdef](https://www.linkedin.com/posts/ngumonelson123_terraform-infrastructure-iac-activity-abcdef)

---

## Notes and Observations

- Learned how to **refactor Terraform code** for reuse across multiple environments.
- Encountered AMI errors — solved by using correct AMI ID for `us-east-1`.
- Faced VPC errors — fixed by explicitly creating **custom VPC**, **subnet**, and **security group**.
- Applied Git-based module versioning using `?ref=v1.0.0`.
- Improved understanding of modular, scalable infrastructure design with Terraform.

---

## Additional Resources Used

- Terraform Documentation: [https://developer.hashicorp.com/terraform/language/modules](https://developer.hashicorp.com/terraform/language/modules)
- Amazon Linux 2 AMI Search
- draw.io (for diagrams)

---

## Time Spent
- Reading: 1 hr
- Infrastructure Deployment: 2 hrs
- Diagram Creation: 45 mins
- Blog Writing: 1 hr
- **Total: 4 hrs 45 mins**

---

## Repository Structure
Day9/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ ├── single-server.png
│ └── web-server.png
├── terraform/
│ ├── single-server/
│ │ └── main.tf
│ └── web-server/
│ └── main.tf
└── submission.md