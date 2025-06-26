# 🌐 Lab 22: Terraform Enterprise (TFE)

## 🔁 Reuse Files from Lab 21

For this lab, I am reusing the exact same Terraform configuration files from Lab 21:

- `main.tf`
- `variables.tf`
- `terraform.tfvars`
- `outputs.tf`

These files define a minimal infrastructure setup — in my case, an EC2 instance with a VPC, subnet, and related components.

---

## 💡 What is Terraform Enterprise (TFE)?

Terraform Enterprise is the **on-premise**, **self-managed** distribution of Terraform Cloud. It’s designed for:

- Enterprises that need strict **security** and **compliance**.
- Organizations that want to **own** where their Terraform **state**, **secrets**, and **variables** are stored.
- Companies that require **advanced auditability**, **network isolation**, and **role-based access controls (RBAC)**.

TFE is typically installed on private infrastructure — like EC2, Kubernetes clusters, or physical servers in a data center. It doesn't rely on the public internet.

---

## 🔍 Key Differences: TFE vs. Terraform Cloud

| Feature                | Terraform Cloud         | Terraform Enterprise       |
|------------------------|--------------------------|-----------------------------|
| **Hosting**            | SaaS by HashiCorp        | Self-hosted (on EC2, VM, etc.) |
| **Internet Required**  | Yes                      | No (can run offline)       |
| **Secrets & State**    | Managed by HashiCorp     | Stored in my infrastructure |
| **Policy Enforcement** | Basic Sentinel           | Full Sentinel + RBAC       |
| **Access Control**     | UI-based team access     | Full Role-Based Access     |
| **Best For**           | Small/medium teams       | Enterprises, gov, finance  |

---

## 🔐 Variables and Secrets in TFE

Just like in Terraform Cloud, I store my variables and secrets in the workspace UI of Terraform Enterprise:

- **Terraform Variables** like `ami_id`, `instance_type`, `vpc_cidr`
- **Environment Variables** like `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

All of these are **securely encrypted**, **never exposed** in logs, and managed independently from the `.tfvars` file.

---

## 🧪 What I Simulate in This Lab

Although I don’t have a real TFE instance, I simulate and walk through the following:

- ✅ Manually creating a **workspace** (as if in TFE dashboard)
- ✅ Uploading code or linking a GitHub repo
- ✅ Setting variables and AWS credentials manually
- ✅ Running `terraform plan` to simulate TFE execution
- ✅ Reviewing **policy gates**, **cost estimation**, **access roles**, and **state locking**

---

## 🧠 What I Learned

By completing this lab, I understand:

- The **value of hosting** Terraform in a private network environment
- How **offline IaC provisioning** works in Terraform Enterprise
- The **differences in compliance, secrets, and security** compared to Terraform Cloud
- When and why I should recommend TFE — especially for enterprise, regulated, or air-gapped deployments

---

✅ **Note:** No real resources were deployed in this simulation. I reused existing files and focused on understanding **TFE concepts and enterprise readiness**.
