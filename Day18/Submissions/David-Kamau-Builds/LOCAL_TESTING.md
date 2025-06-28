# Local Testing Guide

This guide explains how to test the infrastructure code locally without provisioning actual resources.

## Prerequisites

- Terraform 1.5.0 or later
- Go 1.21 or later (for running Terratest)
- AWS CLI configured with credentials
- GCP CLI (optional, only if testing GCP resources)

## Test Modes

### 1. Terraform Validation

Test syntax and configuration without creating resources:

```bash
cd production
terraform init
terraform validate
terraform plan -var="deployment_mode=test"
```

### 2. Module Testing

Test individual modules:

```bash
cd modules/vpc-module
terraform init
terraform validate
terraform plan
```

### 3. Go Tests

Run the Terratest test suite:

```bash
# Windows
cd scripts
run-tests.bat

# Linux/macOS
cd scripts
./run-tests.sh
```

Or run specific tests:

```bash
cd tests
go test -v -run TestVpcModuleValidation
```

## Test Scripts

The repository includes scripts for running tests:

- `scripts/run-tests.sh` (Linux/macOS)
- `scripts/run-tests.bat` (Windows)

These scripts run the Go tests with appropriate timeouts and parallelism.

## Test Categories

1. **Unit Tests**:
   - Fast, no infrastructure created
   - Tests basic Terraform syntax and validation

2. **Integration Tests**:
   - Tests compatibility between modules
   - No infrastructure created

3. **End-to-End Tests**:
   - Disabled by default (requires AWS resources)
   - Can be enabled by modifying test files

## Troubleshooting

Common testing issues:

1. **Backend Errors**:
   - Use `switch-backend.sh local` to use local backend

2. **Missing Variables**:
   - Check that all required variables have default values
   - Use `-var` flag to provide missing values

3. **AWS Credential Issues**:
   - Ensure AWS credentials are configured
   - Use environment variables if needed

4. **Test Timeouts**:
   - Increase timeout with `-timeout` flag
   - Run fewer tests in parallel