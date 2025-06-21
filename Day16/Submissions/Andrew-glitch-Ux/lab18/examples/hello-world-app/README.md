# Hello World App Example

This example demonstrates how to deploy a minimal production-like application using the modular infrastructure setup.

## Included Modules

- VPC
- Public and Private Subnets
- ALB (Application Load Balancer)
- Auto Scaling Group (ASG) with rolling deployment
- Bastion Host

## Usage

```bash
cd examples/hello-world-app
terraform init
terraform apply -var-file="terraform.tfvars"
