# 🌍 Daily Update: Day 19 — Terraform Cloud Integration


### 🎯 Goal:
Learn how to use Terraform Cloud to manage remote state and apply infrastructure provisioning through cloud-based workspaces.

### 🛠️ Hands-On Implementation:

- Created a Terraform Cloud account and organization `tf-challenge`
- Created a workspace `lab20-cloud` and linked it to local CLI
- Configured `main.tf` to use `terraform { cloud {} }` block pointing to Terraform Cloud
- Managed AWS credentials using secure environment variables:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- Deployed a **single EC2 instance** using Terraform Cloud as backend
- Verified remote apply from the Terraform Cloud UI

### 🗂️ Files Created:
- `main.tf` — defined provider and resource
- `variables.tf` — declared input variables (AMI, region, instance type)
- `terraform.tfvars` — actual values (no hardcoded items)
- Terraform credentials saved to `credentials.tfrc.json`

---


### Lab 21: Terraform Enterprise (Self-Hosted)

- Simulate what it would take to migrate or scale up from **Terraform Cloud** to **Terraform Enterprise**
- Focus areas:
  - Discuss infrastructure requirements (e.g. private networking, private VCS, user roles)
  - Simulate or document how team collaboration and governance improves
  - No EC2 provisioning required unless explicitly mentioned
  - Focus will be **planning**, documentation, and setup simulation (no actual self-hosted Enterprise)

---

## 🧠 Reflection:
Today was a smoother experience with Terraform Cloud. I resolved issues related to credentials and successfully ran a full apply workflow using the Terraform Cloud backend. Lab 20 reinforced best practices in remote state management and team-ready IaC.

