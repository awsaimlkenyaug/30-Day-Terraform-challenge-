# ✅ Week 2 – Day 9: Advanced Terraform Modules (Versioning, Nesting & Multi-Environment)
## Personal Information
- **Name:** Denis Nganga
- **Date:** 11/06/2025
- **GitHub Username:** Denisganga

## 📘 Reading
**Continue with Chapter 4 (Pages 115–139)**  
- ✅ "Module Gotchas"  
- ✅ "Module Versioning"

## 🧪 Hands-on Labs
- ✅ **Lab 10: Workspaces**
- ✅ **Lab 11: Modules**

## 🛠️ Activity

### Enhance Your Module
I extended the EC2 instance module created on Day 8 to support multiple environments (`dev`, `staging`, and `production`). Key enhancements:
- Added an `environment` variable to tag EC2 resources dynamically.
- Reorganized project folder into a proper module and environment structure.
- Used environment-specific `terraform.tfvars` files for isolated deployments.

### Deploy Across Environments
Each environment folder (`dev`, `staging`, `production`) contains:
- Its own `main.tf`, `variables.tf`, and `terraform.tfvars`.
- Uses the enhanced module via `source = "../../modules/ec2-instance"`.

Each deployment was executed via:

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```


## ✍️ Blog Post
📝 [**Advanced Terraform Module Usage: Versioning, Nesting, and Reuse Across Environments**](https://medium.com/@denisnganga16/advanced-terraform-module-usage-versioning-nesting-and-reuse-across-environments-f2553fe35367)

## 💡 Blog Post Ideas (Saved)
- "Advanced Terraform Module Usage: Versioning, Nesting, and Reuse Across Environments"
- "Best Practices for Managing Module Versions in Terraform"

## 📢 Social Media Post
```
🔄 Expanded my knowledge of reusable Terraform modules by adding versioning and deploying across environments!
#HUG #hashicorp #HUGYDE @chiche #IaC
```

## ⏱️ Time Taken
**Total Time:** Approximately 5 hours  
- Reading: 1 hour  
- Labs: 1 hour  
- Hands-on Implementation: 2 hours  
- Blog writing & publishing: 1 hour
