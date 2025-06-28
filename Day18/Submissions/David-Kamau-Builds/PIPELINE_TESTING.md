# Pipeline Testing Guide

This document explains how the CI/CD pipeline tests the infrastructure code without provisioning actual resources.

## Test Mode

The infrastructure code supports a "test mode" that allows validation and testing without creating any resources:

```hcl
# Set deployment_mode to "test" to prevent resource creation
terraform apply -var="deployment_mode=test"
```

In test mode:
- All modules use `count = 0` for resources
- Outputs return placeholder values
- Backend uses local state

## GitHub Actions Workflow

The GitHub Actions workflow in `.github/workflows/terraform.yml` runs the following tests:

1. **Format & Validation**:
   - Checks Terraform formatting
   - Validates module syntax and configuration

2. **Unit Tests**:
   - Tests basic Terraform syntax
   - Validates module structure

3. **Integration Tests**:
   - Tests compatibility between modules
   - Runs in parallel for faster execution

4. **Security Scan**:
   - Uses Checkov to scan for security issues
   - Generates SARIF report

5. **Plan**:
   - Creates Terraform plan in test mode
   - Verifies configuration without creating resources

6. **Apply Simulation**:
   - Simulates apply without creating resources
   - Verifies that test mode works correctly

7. **Post-Deploy Tests**:
   - Simulates post-deployment validation
   - Tests compliance and tagging

## Troubleshooting Pipeline Issues

Common pipeline issues and solutions:

1. **Backend Initialization Errors**:
   - Ensure backend.tf is using the simplified configuration
   - Run `terraform init` without `-backend=false`

2. **Timeout Issues**:
   - Increase timeout in workflow configuration
   - Optimize tests to run faster

3. **Security Scan Failures**:
   - Use `soft_fail: true` in Checkov configuration
   - Address security issues in module code

4. **Cache Issues**:
   - Ensure correct paths in cache configuration
   - Check that go.sum file exists

5. **Missing Variables**:
   - Provide default values for all required variables
   - Use conditional expressions for test mode