# Day 25 – Terraform Cloud Cost Estimation & Error Handling

## 🎯 Main Goal
Understand how Terraform Cloud provides cost estimation for infrastructure before deployment, and ensure all modules are cleanly deployed with correct variables and module structures.

## ✅ What I Accomplished
- Integrated reusable modules (`vpc`, `alb`, `asg`) into a Terraform Cloud workspace.
- Successfully pushed code to a remote VCS-connected Terraform Cloud workspace.
- Debugged and resolved several key errors:
  - Missing modules in TFC context.
  - Misformatted variables (e.g., string vs number vs map).
  - Fixed HCL formatting for complex variables like `tags`.
- Observed Terraform Cloud’s automatic **cost estimation** feature in action.
  - Example estimate: `$38.66/month` for provisioned resources (ASG + EC2 + ALB).

## 💡 What I Learned
- Terraform Cloud reads variables from the **Variables tab**, not local `*.tfvars` files unless manually configured.
- When entering variables in TFC:
  - Use `Number` type for integers, **do not quote**.
  - Use `Boolean` for true/false flags, not `"true"` as strings.
  - Use `HCL` type for maps like tags, not text or strings.
- **Cost estimation is done automatically** after the Plan step if enabled in workspace settings and supported by provider (AWS in this case).
- Ensured modules are in correct directory (`modules/`) and symlinked correctly for Terraform Cloud to detect.
- Variable validation is stricter in Terraform Cloud than CLI — great for production readiness.

## 📊 Estimated Monthly Cost (from Terraform Cloud)
EC2 instances (ASG): ~$25.50
Application Load Balancer: ~$13.16
Total: ~$38.66/month


## 🔧 Next Steps
- Reuse this setup to explore **sentinel policies**, **team access**, or **run triggers**.
- Try modifying variables to see **cost impact in real-time** in the plan.
- Experiment with **free vs standard tier** limitations in Terraform Cloud.

---