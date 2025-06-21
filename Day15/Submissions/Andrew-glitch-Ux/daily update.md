## 🚀 Day 15: Multi-Cloud Infrastructure with Terraform (Lab 17)

**Today’s Goal**: Set up the foundation for deploying Docker containers on Kubernetes (EKS) while preparing for multi-cloud infrastructure using Terraform.

---

### 🎯 What I Did

- Prepared project structure for AWS + GCP cloud independence
- Deployed AWS VPC with subnets in selected region
- Defined all config inputs via `terraform.tfvars`
- Used `variables.tf` to avoid hardcoding
- Set up AWS provider using variables (ready for EKS deployment)
- Created Kubernetes provider config (linked to EKS cluster)
- Commented out GCP blocks (for future setup)

---

### 💡 What I Learned

Multi-provider Terraform architecture  
Provider aliasing and input flexibility  
How to prepare EKS + Kubernetes deployments  
How to separate clouds logically in one Terraform project  
How to simulate multi-cloud even if only one is active

---

### ⚒️ Next Steps

- Build and push Docker image to ECR  
- Provision EKS cluster + node group  
- Deploy Kubernetes app (e.g. nginx)  
- Test via LoadBalancer endpoint  
- Optional: Connect GCP once account is available  

---

**Tags**: #Terraform #MultiCloud #AWS #Kubernetes #IaC #DevOps #30daytfchallenge
