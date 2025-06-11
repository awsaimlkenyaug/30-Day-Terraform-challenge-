# Day 5 Submission: Scaling Infrastructure

## Participant Information
- **GitHub Username:** Ngumonelson123
- **Week Number:** 1
- **Target Branch:** week1
- **Days Completed:** [Day 1, Day 2, Day 3, Day 4, Day 5]
- **Check-in Attendance:** Yes

## Submissions Overview

### ✅ Day 5: Scaling Infrastructure

**Topic:** Scaling Infrastructure and Managing Terraform State

**Key Learnings:**
- Understood how Terraform state tracks infrastructure and avoids unnecessary changes.
- Used the `count` meta-argument to scale multiple EC2 instances.
- Implemented a Load Balancer to distribute traffic.
- Learned about the importance of `terraform show` and `terraform state list` in observing infrastructure state.
- Practiced DRY principles with variables and dynamic subnet selection.

**Terraform Features Used:**
- `aws_lb` to configure Load Balancer
- `aws_instance` with `count` to scale instances
- `data` blocks for AMIs and region info
- `terraform show` to inspect state
- `terraform state list` to view state entries

## Screenshots
Architecture diagram and proof of deployment included in the repo.

## Blog Post
**Title:** Managing High Traffic Applications with AWS Elastic Load Balancer and Terraform***** [https://medium.com/@nelsonmbui88/scaling-infrastructure-with-terraform-load-balancer-web-servers-acff765dbd39]
**Link:** [https://www.linkedin.com/posts/nelson-ngumo-869033162_day5-30dayterraformchallenge-iac-activity-7335250471638437890-n9sz?utm_source=share&utm_medium=member_desktop&rcm=ACoAACbNrBEBpmqmiEP6hVsk2sv4gd_ZU_n3IzM]

## Social Media Post
> 🚀 Scaled my infrastructure with AWS Elastic Load Balancer today and using Terraform! #30daytfchallenge #HUG #hashicorp #HUGYDE @chiche #IaC

## Submission Timestamp
- **Date:** June 02, 2025
- **Time:** 10:28:32