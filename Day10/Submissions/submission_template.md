# Day 10 Submission

## Personal Information
- **Name:** Nelson Ngumo
- **Date:** 2025-06-26
- **GitHub Username:** ngumonelson123

## Task Completion
- [x] Completed Chapter 5 of "Terraform: Up & Running"
- [x] Completed Lab 11: Modules
- [x] Completed Lab 12: Module Sources
- [x] Refactored Terraform code to use loops (`count`, `for_each`)
- [x] Added conditionals to control deployment
- [x] Created architecture diagrams
- [x] Published blog post
- [x] Shared progress on social media

## Overview
Day 10 focused on making Terraform infrastructure dynamic and reusable using `count`, `for_each`, and conditional logic. I refactored my existing EC2 infrastructure to deploy multiple instances using `count`, iterate over environments using `for_each`, and toggle EC2 deployment with a boolean condition.

## Code Highlights
**Multiple EC2s with `count`:**
```hcl
resource "aws_instance" "multi" {
  count = var.deploy_ec2 ? var.instance_count : 0
  ami = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  ...
}
```

**Instances per environment with `for_each`:**
```hcl
variable "servers" {
  default = {
    dev     = "t2.micro"
    staging = "t2.micro"
    prod    = "t2.small"
  }
}

resource "aws_instance" "for_each_demo" {
  for_each = var.servers
  ...
  tags = {
    Name = "${each.key}-server"
  }
}
```

## Architecture Diagram
![Looped EC2 Deployment](./architecture/count-loop-diagram.png)

## Blog Post
- **Title:** Mastering Loops in Terraform
- **Link:** https://medium.com/@ngumonelson123/mastering-loops-in-terraform

## Social Media Post
```text
💡 Learned how to use loops in Terraform for dynamic deployments!
Refactored my infra to deploy multiple EC2s using `count` and `for_each` — no more repetition!

📌 Blog: Mastering Loops in Terraform
📦 GitHub: https://github.com/ngumonelson123

#Terraform #IaC #CloudEngineering #DevOps #AWS #30DayTerraformChallenge
```

## Notes and Observations
- `count` is best for identical resources, `for_each` for distinct ones.
- Used conditionals to prevent EC2 deployment if `deploy_ec2 = false`.
- The infra is now cleaner, dynamic, and easier to extend to multiple environments.

## Additional Resources Used
- Terraform Docs: https://developer.hashicorp.com/terraform/language/expressions/for
- Medium community posts
- draw.io (for visuals)

## Time Spent
- Reading & Labs: 1.5 hrs
- Code Refactor: 1 hr
- Testing Deployments: 30 min
- Diagram Creation: 30 min
- Blog + Social Media: 1 hr
- **Total Time: 4.5 hrs**