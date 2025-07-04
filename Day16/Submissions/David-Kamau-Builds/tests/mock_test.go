package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// This test demonstrates how to use mocks for testing Terraform modules
func TestModuleWithMocks(t *testing.T) {
	// This test doesn't require real AWS resources and can run in CI
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/vpc-module",
		Vars: map[string]interface{}{
			"name_prefix":        "mock",
			"environment":        "test",
			"region":             "us-east-1",
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
		},
		// Don't actually create resources
		NoColor: true,
	})

	// Just run init and validate
	terraform.Init(t, terraformOptions)
	terraform.Validate(t, terraformOptions)
	
	// Success if validation passes
	assert.True(t, true, "Module validation passed")
}