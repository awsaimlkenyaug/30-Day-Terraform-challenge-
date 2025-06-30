# 🗓️ Daily Update – Day 26

## ✅ What I Accomplished Today

1. **Multi-Subnet VPC Module**
   - Successfully built and debugged a reusable VPC module supporting two public subnets, internet gateway, route table, and associations.
   - Learned to correctly define and reference outputs like `public_subnet_ids` for downstream modules (e.g., ASG, EC2).

2. **Fixed Terraform Validation Issues**
   - Resolved multiple validation errors caused by incorrect or missing output references (e.g., `public_subnet_id` vs `public_subnet_ids`).
   - Understood why Terraform requires precise output names and unique declarations within `outputs.tf`.

3. **Security Group Integration**
   - Created a security group directly in the environment (not in a module), and linked it to the EC2 instance using a variable.
   - Observed how Terraform prompts for values like `security_group_id` when a value isn't explicitly wired in the code.

4. **Handled Real AWS Errors**
   - Investigated and resolved a real AWS API error (`InvalidSubnet.Conflict`) when overlapping CIDR blocks were used.
   - Learned the importance of proper CIDR planning across multiple subnets to avoid provisioning failures.

5. **Version Control Workflow**
   - Committed all finalized code from Day 26 and pushed to a new branch `week5` to continue work cleanly.
   - Reinforced best practices around working with Git branches, avoiding data loss, and preparing for future merges.

---

## 🧠 Bonus Insight

CloudWatch is a partially free service — core metrics (like CPU, disk, network) are free, but custom metrics, dashboards, and alarms may incur charges.

---
