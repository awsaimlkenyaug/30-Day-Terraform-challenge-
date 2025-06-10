# 🚀 Day 12 – IAM & Network Modules (Terraform Challenge)

## ✅ What Was Done
- Implemented a reusable IAM user module with `for_each` to provision 3 users.
- Created a reusable network module to deploy 2 public subnets across AZs.
- Replaced all hardcoded values with variables using `terraform.tfvars`.
- Used conditional logic to toggle between AWS regions.
- Validated, planned, and applied the Terraform configuration successfully.
- Drew two infrastructure diagrams using draw.io.

## 🛠️ Tools Used
- Terraform v1.6+
- AWS CLI
- Draw.io
- VS Code + Git Bash

## 📌 Key Concepts Practiced
- `for_each` with maps and lists
- Dynamic module input
- Conditional logic with ternary operators
- Variable files and `terraform.tfvars`
- Infrastructure diagramming with draw.io

## ⏳ Time Spent
- Total: ~4 hours

## 🔄 Next Steps
- Start Lab 13: Possibly involving server provisioning and new modules
- Publish blog and social post (optional)
- Review remote state and outputs

---
