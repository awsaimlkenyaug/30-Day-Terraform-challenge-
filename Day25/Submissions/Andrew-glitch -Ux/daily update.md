# 🚀 Day 25 - 30-Day Terraform Challenge

## ✅ Today's Goal  
Deploy a static website on **AWS S3** using **Terraform**, and integrate it with **CloudFront** for secure global delivery — all while following best practices like remote state management and modular design.

---

## 🛠️ What I Built

### 🔹 S3 Static Website Module
- Created a reusable Terraform module to provision:
  - An S3 bucket for hosting
  - Website configuration (index.html & error.html)
  - Public access policy
  - Public access block controls

### 🔹 CloudFront Module
- Built a module to set up:
  - A CloudFront distribution pointing to the S3 website
  - Default root object (`index.html`)
  - HTTPS delivery configuration

### 🔹 Environment Setup
- Created `envs/dev` to call both modules
- Used `terraform.tfvars` for dynamic configuration
- Linked modules with outputs and variables
- Managed state with a dedicated remote backend (S3 + DynamoDB)

---

## 💡 What I Learned
- How **Terraform modules** promote clean, DRY, and testable code
- The role of **remote state** and how to manage it securely
- Difference between regular S3 buckets vs. website-enabled ones
- How CloudFront works with S3 to deliver static content globally with HTTPS

---

## 🌟 Realization of the Day
> Infrastructure as Code isn't just automation — it's *architecture with intention*.  
Watching modules collaborate to spin up real infrastructure was powerful.

---

