# 📝 Daily Update - Day 15

📅 Date: 2025-06-15  
📁 Path: `Day14/Submissions/Andrew-glitch-Ux/`

---

## ✅ Completed Labs

### 🔐 Lab 15: Secrets Management with AWS Secrets Manager
- Integrated `aws_secretsmanager_secret` and `aws_secretsmanager_secret_version`.
- Used Terraform variables to inject secret names and values securely.
- Demonstrated best practices: no hardcoding secrets, using `sensitive = true`, and controlling IAM access.
- Validated secret retrieval using outputs (only for testing, not in production).

### 🌍 Lab 16: Multi-Region Deployment (Same Provider)
- Designed Terraform modules for deploying VPC + EC2 in **two AWS regions** (`eu-north-1`, `eu-west-1`).
- Used **provider aliases** (`aws` and `aws.secondary`) to cleanly split deployments.
- Followed **clean folder structure**: separated `network` and `compute` modules.
- Injected all configurations via `terraform.tfvars` (no hardcoding).
- Fixed provider warnings using `required_providers` inside modules.
- Exposed `instance_id` and `public_ip` from both compute modules.
- Successfully validated and planned infrastructure across both regions.

---

## 🧠 Key Concepts Learned

- Secrets Manager integration using Terraform  
- Proper variable injection for secret and non-secret data  
- Multi-region deployments using a single provider with aliases  
- Fault-isolation by keeping deployments independent across regions  
- Terraform module reusability and output exposure best practices  

---

