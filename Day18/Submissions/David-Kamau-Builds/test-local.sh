#!/bin/bash
# Local Testing Script for Unix/Linux/macOS

set -e

echo "Starting local tests..."

# Test Go dependencies
echo "Testing Go dependencies..."
cd tests
go mod verify
go test -v -run "TestTerraformSyntax|TestVpcModuleOutputs|TestSecurityGroupRules|TestVpcModuleValidation|TestModuleCompatibility|TestVpcModulePlan"
cd ..

# Test Terraform formatting
echo "Checking Terraform formatting..."
terraform fmt -check -recursive

# Validate modules
echo "Validating Terraform modules..."
modules=("modules/vpc-module" "modules/rds-module" "modules/eks-module" "modules/secrets-module" "modules/blue-green-module" "modules/gcp-module")

for module in "${modules[@]}"; do
    echo "Validating $module..."
    cd "$module"
    terraform init -backend=false
    terraform validate
    cd - > /dev/null
done

echo "All local tests passed!"