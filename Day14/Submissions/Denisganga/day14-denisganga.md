# Day 14 Submission

## Personal Information
- **Name:** Denis Nganga 
- **Date:** June 21, 2025  
- **GitHub Username:** Denisganga  

---

## Task Completion
- [x] Read  
- [x] Completed Required Hands-on Labs
- [x] Wrote Blog Post  
- [x] Shared on Social Media   

---

## 📘 Reading

**Book:** Terraform: Up & Running (Chapter 7)  
**Sections Covered:**  
- Working with One Provider  
- What Is a Provider?  
- How Do You Install Providers?  
- How Do You Use Providers?  
- Working with Multiple Copies of the Same Provider  

**Goal:** Understood how providers work in Terraform, how to install and configure them, and how to use aliases for managing multiple configurations of the same provider.

---

## 🧪 Hands-on Labs

- ✅ Lab 15: Terraform Testing  
- ✅ Lab 16: Terraform CI/CD Integration  

These labs helped reinforce practical usage and automation with Terraform providers in modern workflows.

---

## 🛠️ Activity: Provider Configuration

### ✔️ What I Did:
- Configured **two AWS provider blocks** using aliases (`us_east`, `us_west`)  
- Deployed **EC2 instances** in both `us-east-1` and `us-west-2`  
- Ensured AMIs matched each region  
- Used provider version pinning (`~> 5.0`) for stability  

### 🌍 Output:
```hcl
east_instance_id = "i-027ecc4e6581bdabc"
west_instance_id = "i-0655063fa519a1283"
```

Resources were created successfully in both regions, meeting the goal of multi-region infrastructure with provider aliases.


## ✍️ Blog Post

**Title:** [Getting Started with Multiple Providers in Terraform](https://medium.com/@denisnganga16/getting-started-with-multiple-providers-in-terraform-3ee9c4f07a1b)

The blog explains:
- What provider aliases are  
- How to deploy resources across AWS regions  
- How versioning prevents breakage  
- Hands-on setup with real Terraform code  

---

## 📣 Social Media Post

🔧 Learned how to manage multiple providers in Terraform today—getting ready to scale my infrastructure across multiple regions and accounts!  
#30daytfchallenge #HUG #hashicorp #HUGYDE @Chi Che. #IaC #terraform

