# Day 13 Submission & Guide

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** June 26, 2025
- **GitHub Username:** ngumonelson123

---

## Task Completion
- [x] Read Chapter 6 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Implemented secure management of sensitive data using AWS Secrets Manager
- [x] Written and published blog post
- [x] Posted on social media
- [x] Created markdown file with Terraform code and architecture diagrams
- [x] Wrote advanced guide on secure secrets management
- [x] Created pull request

---

## Blog Post
- **Title:** How to Handle Sensitive Data Securely in Terraform
- **Link:** [Add your blog post link here]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [Add your LinkedIn or Twitter link here]

## Notes and Observations
- Learned how `.tfstate` files can leak secrets
- AWS Secrets Manager integrates well with Terraform
- `sensitive = true` prevents accidental exposure

## Additional Resources Used
- AWS Secrets Manager Docs
- Terraform Registry
- HashiCorp Vault Docs

## Time Spent
- Reading: 2 hours
- Infra Deployment: 2 hours
- Diagrams: 30 mins
- Blog Writing: 1.5 hours
- Total: ~6 hours

---

## Repository Structure
```
Day13/
└── Submissions/
    └── ngumonelson123/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/main.tf
        │   └── web-server/main.tf
        ├── secure-secrets-multicloud-guide.md
        └── submission.md
```

---

# Advanced Guide: Secure Secrets Management Across Cloud Environments with Terraform

## 🔐 Why Secure Secrets Matter

Secrets like passwords, API keys, and tokens can leak through:
- Hardcoded variables
- Unmasked outputs
- `terraform.tfstate` files
- GitHub commits (accidental)

## ✅ Tools for Secrets Management

| Cloud | Tool |
|-------|------|
| AWS   | Secrets Manager |
| Azure | Key Vault |
| GCP   | Secret Manager |
| Any   | HashiCorp Vault |

## 🛠️ Example 1: AWS Secrets Manager

```hcl
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "MyDBPassword"
}

output "db_password" {
  value     = data.aws_secretsmanager_secret_version.db_password.secret_string
  sensitive = true
}
```

## 🛠️ Example 2: HashiCorp Vault

```hcl
provider "vault" {
  address = "https://vault.mycompany.com"
}

data "vault_generic_secret" "example" {
  path = "secret/data/db"
}

output "db_password" {
  value     = data.vault_generic_secret.example.data["password"]
  sensitive = true
}
```

## 💡 Best Practices

- Use `sensitive = true` on outputs
- Avoid committing `.tfstate` files — add to `.gitignore`
- Use encrypted remote state (e.g., S3 with encryption, Terraform Cloud)
- Set IAM permissions to restrict access to secret stores
- Use environment variables for provider credentials

## 📘 Final Thoughts

Terraform is powerful, but it won’t protect your secrets unless you design for it. Use secrets managers and follow best practices to stay secure.

---

# How to Handle Sensitive Data Securely in Terraform

When managing infrastructure as code, secrets like API keys, passwords, and tokens often need to be referenced in your Terraform code. But hardcoding secrets can lead to serious security risks.

## Why Secrets Need Protection

Without proper handling, secrets may:
- Be exposed in Git history
- Leak through Terraform output
- Show up in `terraform.tfstate` files (which are plaintext!)

## Secrets Management Options

There are several tools to help manage secrets securely:

- **AWS Secrets Manager**
- **HashiCorp Vault**
- **Azure Key Vault**
- **GCP Secret Manager**

## How I Used AWS Secrets Manager

I created a secret via CLI:

```bash
aws secretsmanager create-secret   --name MyDBPassword   --secret-string "SuperSecret123"   --region us-east-1
```

Then, I referenced the secret in Terraform:

```hcl
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "MyDBPassword"
}
```

To keep it hidden from logs and output:

```hcl
output "db_password" {
  value     = data.aws_secretsmanager_secret_version.db_password.secret_string
  sensitive = true
}
```

## Lessons Learned

- Marking outputs as `sensitive = true` helps prevent exposure
- Secrets should never be committed to version control
- Secure state files using remote backends and encryption

## Final Thoughts

Managing secrets in Terraform is non-trivial — but with proper tools and structure, it becomes manageable and secure.

---

🔐 Stay safe and ship securely!