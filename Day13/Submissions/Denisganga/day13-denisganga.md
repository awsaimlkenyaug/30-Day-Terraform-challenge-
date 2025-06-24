# Day 13 Submission

## Personal Information
- **Name:** Denis Nganga  
- **Date:** June 21, 2025  
- **GitHub Username:** Denisganga

---

## Task Completion
- [x] Read  
- [x] Completed Required Hands-on Labs  
- [x] Deployed Single Server  
- [x] Deployed Web Server  
- [x] Created Infrastructure Diagrams  

---

## Day 13: Managing Sensitive Data in Terraform

### 📖 Overview

Today’s focus was one of the most important in any Terraform workflow — **handling secrets securely**. Instead of hardcoding sensitive values like passwords or API keys in `.tf` or `.tfvars`, we used **AWS Secrets Manager** to store and retrieve secrets securely.

The goal was to:  
- Implement encrypted secret storage  
- Avoid leaking secrets in Terraform state files  
- Integrate secrets into real infrastructure like EC2  

---

### 🧪 Terraform Code Summary

We used the following Terraform setup for AWS:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "db" {
  name        = "multi-cloud-db-password"
  description = "Shared DB password"
}

resource "aws_secretsmanager_secret_version" "db_value" {
  secret_id     = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = "admin"
    password = "SuperSecureP@ssw0rd"
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db.arn
}
```

The secret is encrypted by default with AWS KMS and not exposed in state files.

---

### ✅ Results

- Terraform successfully deployed the secret  
- Verified the secret exists in AWS Secrets Manager  
- Confirmed secrets are masked in `terraform.tfstate`  
- Deployed EC2 that can fetch and use the secret at runtime  

---

### 🧠 Labs Completed

- ✅ Lab 14: Module Versioning  
- ✅ Lab 15: Terraform Testing  

---

## 📝 Blog Post

**Title:** [How to Handle Sensitive Data Securely in Terraform](https://medium.com/@denisnganga16/how-to-handle-sensitive-data-securely-in-terraform-0b34559247af)

Summary: I explored how to secure Terraform secrets using AWS Secrets Manager. This includes masking state files, encrypting secrets, and avoiding bad practices like hardcoding credentials.

---

## 🔗 Social Media Post

🔗 [View Post on LinkedIn](https://www.linkedin.com/posts/denis-nganga16_30daytfchallenge-30daytfchallenge-hug-activity-7343195475329626112--v6s?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD6f18kBkqYbwrS6aVUAbqFNTkKbSj8rzzk)```

---

## 📘 Advanced Guide

I also wrote an advanced, GitHub-ready multi-cloud secrets management guide covering:

- AWS Secrets Manager  
- Azure Key Vault  
- Google Secret Manager  
- Best practices for encryption, IAM, and audit logging  
- Terraform code examples

**GitHub Repository:** [terraform-cross-cloud-secret-management](https://github.com/Denisganga/terraform-cross-cloud-secret-management)

---

## 📁 Submission Details

This file includes:  
- Terraform code snippet  
- Blog link  
- Repo link  
- Completion log  

Diagrams, full `.tf` files, and structure are included in the GitHub repo and the `day13-secure-secrets` branch.

---

🛡️ **Security isn't optional — it's infrastructure.**
