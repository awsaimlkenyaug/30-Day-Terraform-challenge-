# 🚀 Day 9 – Terraform Challenge Daily Update

## 📚 What I Learned Today
- The concept and implementation of **Terraform Workspaces**
- How to deploy the same infrastructure across multiple environments (`dev`, `staging`, `prod`) using one codebase
- How state files are isolated per workspace
- Applied reusable modules for DRY configuration

## 🛠️ What I Built
- Created environment-aware infrastructure using `terraform.workspace`
- Deployed:
  - VPC
  - Public Subnet
  - Security Group with HTTP and SSH access
  - EC2 Instance
- Used modular structure and variables
- Created architecture diagram reflecting all three environments under one AWS account

## 🔧 Tools Used
- Terraform CLI
- VS Code
- Git Bash
- Draw.io (for diagrams)
- AWS (Region: eu-north-1)

## ⚔️ Challenges Faced
- Debugging workspace-specific outputs
- Adjusting remote backend paths when using multiple environments
- Ensuring outputs reflect the selected workspace

## ✅ Accomplishments
- Fully deployed three isolated environments with identical structure
- Learned how to keep state files separate
- Practiced real-world Terraform deployment scenarios

## 🖼️ Diagram
Architecture diagram placed inside:
