# 🚀 Daily Terraform Update – Day 18 (2025-06-20)

## 👨‍💻 Focus
- Building reusable `subnet` modules for public subnets A and B.
- Wiring up those modules from `examples/hello-world-app`.

## ✅ What I Accomplished
- Created a `subnet` module with all needed files: `main.tf`, `variables.tf`, `outputs.tf`.
- Called it twice from root: once for `public_subnet_a`, once for `public_subnet_b`.
- Validated all variables are passed from `.tfvars`, avoiding any hardcoding.
- Fixed module path issues and ran `terraform init` successfully.

## 🔍 Key Concepts Learned
1. Reusing modules to avoid duplicated logic.
2. Calling modules with different inputs for different resources.
3. Structuring Terraform code for scale and production-readiness.
4. Terraform folder structure and module resolution.
5. Isolating infrastructure definitions from deployment configurations.

## 🛠️ Next Steps
- Visualize the full infrastructure used in this lab.
- Move on to ALB and ASG composition in next lab.

