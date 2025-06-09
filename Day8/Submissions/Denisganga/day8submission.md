# Day 8 – Terraform 30-Day Challenge
## Personal Information
- **Name:** Denis Nganga
- **Date:** 2025-06-09
- **GitHub Username:** Denisganga

## ✅ Task: Create and Use a Terraform Module

### Description

- **Create a Module**: Built a basic Terraform module to provision an EC2 instance.
- **Deploy Infrastructure Using the Module**: Used the module to deploy infrastructure in AWS using real values for AMI, subnet, instance name, etc.
- **Goal**: Successfully create a reusable Terraform module and use it to deploy infrastructure.

---

## 📁 Project Structure

```bash
Day8/
└── Submissions/
    └── Denisganga/
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf

```

---

## ⚙️ Module Usage Example

```hcl
module "ec2" {
  source        = "./modules/ec2-instance"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  instance_name = var.instance_name
}
```

---

## 🔐 AWS Configuration

I configured AWS credentials using environment variables:

```bash
export AWS_ACCESS_KEY_ID=your-access-key
export AWS_SECRET_ACCESS_KEY=your-secret-key
export AWS_DEFAULT_REGION=us-east-1
```

This allowed Terraform to authenticate and provision the EC2 instance successfully.

---

## ✅ Outcome

- Wrote a reusable EC2 module
- Passed input variables manually using `terraform plan` and `terraform apply`
- Deployed infrastructure in AWS using the module
- Learned about Terraform root modules vs nested modules

---

## 📖 Blog Post

**Title**: [Building Reusable Infrastructure with Terraform Modules](https://medium.com/@denisnganga16/building-reusable-infrastructure-with-terraform-modules-d3a9f9587c3a)

---

## 💡 Key Learnings

- How to structure a reusable module
- How to pass variables to modules
- How to configure Terraform with AWS credentials
- Difference between root module and nested module
- How to write cleaner and more scalable IaC

---

#Day8 #TerraformModules #30DaysOfTerraform #IaC #AWS #DenisGanga
