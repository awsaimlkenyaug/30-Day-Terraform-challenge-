# 🌍 Terraform Challenge – Day 5 Update

## 🔧 What We Did

We scaled our Terraform-managed infrastructure by launching multiple EC2 web servers using the `count` meta-argument. To manage traffic efficiently, we configured an AWS Application Load Balancer (ALB) with listeners and target groups. We also set up supporting network components like an Internet Gateway, route tables, and security groups. Additionally, we explored the concept of the Terraform state file and its critical role in infrastructure lifecycle tracking.

---

## 📚 What We Learned

- **Scaling with Terraform:** Used `count` to provision multiple EC2 instances.
- **Load Balancer Setup:** Configured ALB with target groups and HTTP listeners.
- **AWS Networking:** Established IGW, route tables, and subnet associations.
- **Terraform State Management:** Learned how state tracks real infra, and why manual changes are risky.
- **Dependency Troubleshooting:** Debugged errors by applying resources in logical stages.

---

## 🛠️ Tools Used

| Tool              | Purpose                                      |
|-------------------|----------------------------------------------|
| Terraform CLI     | Define, plan, apply infrastructure           |
| AWS Provider      | Create and manage AWS resources              |
| AWS Console       | Verify infrastructure and debug issues       |
| VS Code           | Write and organize Terraform files           |
| Draw.io (Planned) | Visualize infrastructure                     |

---

## 🚧 Challenges Faced

| Issue                                | Resolution                                       |
|--------------------------------------|--------------------------------------------------|
| ALB creation error (no IGW)          | Added IGW and route table before ALB            |
| CIDR block confusion                 | Used `cidrsubnet` for precise subnetting        |
| Route table not associating         | Verified subnet associations in Terraform       |
| ALB Target Group health checks failing | Verified EC2 security group and listener config |

---

## ✅ What We Accomplished

- Scaled EC2 web servers using `count`
- Created fully functional Application Load Balancer
- Setup proper public network access with IGW and route tables
- Strengthened understanding of Terraform state and dependencies
- Documented configuration and summarized progress for submission

---

## 🧾 Conclusion

Day 5 elevated my Terraform confidence. The ability to scale infrastructure and balance traffic without changing much code shows the real power of declarative IaC. Despite errors, solving networking and state issues reinforced practical cloud engineering skills. I'm now comfortable with foundational patterns used in real production environments.
