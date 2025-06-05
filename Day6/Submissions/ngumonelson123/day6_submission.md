# Day 6 Submission

## Personal Information
- **Name**: Nelson Ngumo
- **Date**: 2025-06-02
- **GitHub Username**: ngumonelson123

---

## Task Completion
✅ Read Chapter 3 of "Terraform: Up & Running"  
✅ Completed Required Hands-on Labs (Output Values & State Management)  
✅ Deployed Single Server (EC2 instance)  
✅ Deployed Web Server (2 EC2 instances)  
✅ Created Infrastructure Diagrams for both deployments  
✅ Configured remote state storage using S3 + DynamoDB  
✅ Generated outputs and inspected `.tfstate` files

---

## Infrastructure Details

### 🔹 Single Server Deployment
- **Region**: `us-east-1`
- **Instance Type**: `t2.micro`
- **Key Features**:
  - Basic EC2 instance
  - Local then remote state (S3 backend)
  - No output values

### 🔹 Web Server Deployment
- **Region**: `us-east-1`
- **Instance Type**: `t2.micro` (×2)
- **Key Features**:
  - Used `count` to create 2 EC2s
  - Output block to show public IPs
  - Remote state with locking

---

## Infrastructure Diagrams

Stored in the `architecture/` folder:
- 📄 `single-server.png` – one EC2 with local and remote state option
- 📄 `web-server.png` – multiple EC2s using shared state (S3 + DynamoDB)

---

## Blog Post
- **Title**: Managing Terraform State: Best Practices for DevOps  
- **Link**: [Coming soon]

---

## Social Media
- **Platform**: LinkedIn  
- **Post Link**: [https://linkedin.com/in/ngumonelson123](https://linkedin.com/in/ngumonelson123)

---

## Notes and Observations
- Learned that Terraform state tracks the actual deployed infrastructure
- Using `terraform.tfstate` locally can be risky in teams
- Configuring S3 backend ensures state consistency
- DynamoDB locking prevents race conditions during `apply`

---

## Additional Resources Used
- AWS S3 & DynamoDB Docs  
- HashiCorp Terraform Backend Documentation  
- Blog examples from the Terraform Community

---

## Time Spent
- **Reading**: 1.5 hours  
- **Infrastructure Deployment**: 1 hour  
- **Diagram Creation**: 0.5 hour  
- **Blog Writing**: 1 hour  
- **Total**: 4 hours

---

## Repository Structure
Day6/
└── Submissions/
└── ngumonelson123/
├── architecture/
│ ├── single-server.png
│ └── web-server.png
├── terraform/
│ ├── single-server/
│ │ └── main.tf
│ │ └── backend.tf
│ └── web-server/
│ └── main.tf
│ └── backend.tf
└── submission.md