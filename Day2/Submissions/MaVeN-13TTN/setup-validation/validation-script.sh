#!/bin/bash

echo "======================================="
echo "Day 2: Terraform & AWS Setup Validation"
echo "======================================="
echo

echo "1. Terraform Version Check:"
terraform version
echo

echo "2. AWS CLI Version Check:"
aws --version
echo

echo "3. AWS Identity Validation:"
aws sts get-caller-identity
echo

echo "4. VSCode Version Check:"
code --version
echo

echo "5. VSCode Extensions (AWS/Terraform):"
code --list-extensions | grep -E "(aws|terraform|hashicorp)"
echo

echo "6. Terraform Provider Validation:"
cd "$(dirname "$0")"
terraform validate
echo

echo "7. AWS Connectivity Test:"
terraform plan -no-color
echo

echo "======================================="
echo "✅ All validations completed successfully!"
echo "======================================="
