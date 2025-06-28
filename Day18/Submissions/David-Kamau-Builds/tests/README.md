# Terraform Tests

This directory contains comprehensive automated tests for the Terraform infrastructure using Terratest.

## Quick Start

```bash
# Install dependencies
go mod tidy

# Run all tests
go test -v ./...

# Run specific test suites
go test -v -run TestTerraformSyntax     # Unit tests
go test -v -run TestModuleWithMocks     # Mock tests  
go test -v -run TestVpcModule           # VPC tests
go test -v -run TestModuleCompatibility # Integration tests
```

## Test Files

- `unit_test.go` - Terraform syntax and validation tests
- `integration_test.go` - Module compatibility and infrastructure tests
- `vpc_test.go` - VPC module specific tests
- `rds_test.go` - RDS module specific tests
- `mock_test.go` - Mock tests for CI/CD
- `e2e_test.go` - End-to-end tests (disabled by default)

## Test Categories

### 🔧 Unit Tests
Fast tests that validate Terraform syntax and configuration without external dependencies.

### 🔗 Integration Tests  
Tests that validate module interactions and infrastructure planning.

### 🌐 End-to-End Tests
Full infrastructure deployment tests (use with caution - AWS costs apply).

### 🎭 Mock Tests
Simulated tests for fast CI/CD feedback.

## Environment Setup

```bash
# Required for integration/E2E tests
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
export AWS_DEFAULT_REGION=us-east-1

# Optional: Enable E2E tests
export RUN_E2E_TESTS=true
```

## CI/CD Integration

Tests are automatically run in GitHub Actions:
- Unit tests on every commit
- Integration tests on pull requests
- Security scanning with Checkov
- Post-deployment validation

See `../.github/workflows/terraform.yml` for full pipeline configuration.