# 🚀 Day 24: Security Best Practices — 30-Day Terraform Challenge

Today’s focus was on security-first infrastructure deployment using Terraform Cloud. I successfully pushed my infrastructure code (VPC, ASG, ALB modules) to GitHub under version control, simulated collaboration via a new branch, and linked the code to a new Terraform Cloud workspace.

Although Sentinel enforcement policies require a paid plan, I previously tested Sentinel rules in earlier labs and added inline security comments in my `.tf` files to reflect secure practices (e.g., restricting CIDR ranges, subnet isolation). This day solidified the value of secure IaC, team workflows, and how Terraform Cloud enforces compliance at scale.

---

## ✅ Activities Completed:
- Initialized and validated Terraform files.
- Created a new GitHub branch (`lab24-security`) and pushed code.
- Created a new workspace on Terraform Cloud.
- Verified GitHub integration for CI-style automation.
- Reflected on previous Sentinel use and improved code with inline security justifications.

---

## 🔐 Key Practices Demonstrated:
- Version control for infrastructure code.
- Secure CIDR blocks, subnet isolation, and module reusability.
- Inline documentation for security reasoning.
- Terraform Cloud workspace isolation and workflow linkage.
- Awareness of Sentinel’s role in automated governance (even if not enforced today).

---

## 🧠 Top 5 Things I Learned Today:

1. **Version control is essential** in infrastructure teams — using branches mirrors real-world collaboration workflows.
2. **Terraform Cloud workspaces** help isolate environments and workflows, aligning with CI/CD pipelines.
3. **Inline security decisions** (like CIDR restrictions) make your Terraform code auditable and maintainable.
4. **Sentinel policies**, even when not enforced, represent a best-practice mindset for compliance and cost governance.
5. **Security in IaC is proactive** — build it into your design with validations, roles, resource tagging, and modularity.

---

Grateful for all I've learned so far. On to the final day! 💪 #30DayTfChallenge #Terraform #IaC #SecurityBestPractices
