# Terraform Module Tests

This directory contains tests for the Terraform modules using Terratest.

## Prerequisites

- Go 1.16 or later
- Terraform 1.5.0 or later

## Testing Approaches

This project uses three testing approaches:

1. **Mock Testing**: Validates module syntax and structure without creating resources
2. **Plan Testing**: Validates that the expected resources would be created
3. **Apply Testing**: Creates actual resources (requires AWS credentials)

## Running Tests

To run all tests:

```bash
cd tests
go test -v
```

To run a specific test:

```bash
cd tests
go test -v -run TestModuleWithMocks
```

## Test Structure

Each test file follows one of these patterns:

### Mock Testing
```go
func TestModuleWithMocks(t *testing.T) {
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: "../modules/vpc-module",
        Vars: map[string]interface{}{
            // Test variables
        },
    })

    terraform.Init(t, terraformOptions)
    terraform.Validate(t, terraformOptions)
}
```

### Plan Testing
```go
func TestModuleWithPlan(t *testing.T) {
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: "../modules/vpc-module",
        Vars: map[string]interface{}{
            // Test variables
        },
    })

    terraform.Init(t, terraformOptions)
    planOutput := terraform.Plan(t, terraformOptions)
    
    // Assert plan contains expected resources
    assert.Contains(t, planOutput, "aws_vpc.main")
}
```

### Apply Testing (requires AWS credentials)
```go
func TestModuleWithApply(t *testing.T) {
    t.Skip("Skipping test that requires real AWS resources")
    
    terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
        TerraformDir: "../modules/vpc-module",
        Vars: map[string]interface{}{
            // Test variables
        },
    })

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)
    
    // Assert outputs
    vpcId := terraform.Output(t, terraformOptions, "vpc_id")
    assert.NotEmpty(t, vpcId)
}
```

## CI Integration

These tests are integrated with the CI pipeline. In CI environments:
- Mock tests and plan tests run automatically
- Apply tests are skipped to avoid creating real resources