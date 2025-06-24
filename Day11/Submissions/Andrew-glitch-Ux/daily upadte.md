# 🌍 30-Day Terraform Challenge – Day 11

## ✅ What I Learned Today
- How to **compose multiple Terraform modules** to build reusable infrastructure.
- Linking outputs from one module (VPC) into another (Web Server).
- Using **conditional logic** in Terraform to control resource creation (`deploy_instance` flag).
- Refactoring all inputs to come from `terraform.tfvars` (no hardcoding).
- Terraform best practices for module structure and reusability.

## 🛠️ What I Built
- **Modular VPC**:
  - CIDR block and subnet CIDR from variables.
  - Internet Gateway, public subnet, and routing handled.
- **Modular Web Server**:
  - Accepts VPC ID, Subnet ID, ingress and egress rules from variables.
  - Security group + EC2 instance with conditional deployment.
- **Live Environment (`live/dev`)**:
  - Orchestrates both modules using shared values.
  - Ensures infrastructure is DRY and environment-specific.

## 🔧 Tools and Tech Used
- Terraform CLI (v1.x)
- AWS (eu-north-1 region)
- Visual Studio Code + Git Bash
- AMI: `ami-006b4a3ad5f56fbd6`
- Instance Type: `t3.micro`

## 🧠 Challenges Faced
- ⚠️ Got an error due to duplicate output declarations (resolved by removing output blocks from `variables.tf`).
- ❗ Forgot to pass all required variables at first — fixed after aligning `main.tf`, `variables.tf`, and `terraform.tfvars`.
- ☑️ Instance was outside subnet diagrammatically — fixed in architecture design step.

## 🏆 Accomplishments
- Fully working **composed setup using reusable modules**.
- No hardcoded values — all config via `.tfvars`.
- Clean and scalable structure ready for different environments.
