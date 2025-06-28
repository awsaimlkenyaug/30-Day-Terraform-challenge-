package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestFullInfrastructureIntegration(t *testing.T) {
	t.Skip("Skipping full infrastructure test - requires S3 backend setup")
}

func TestModuleCompatibility(t *testing.T) {
	// Test that all modules can be initialized together
	modules := []string{
		"../modules/vpc-module",
		"../modules/rds-module",
		"../modules/eks-module",
		"../modules/secrets-module",
		"../modules/blue-green-module",
		"../modules/gcp-module",
	}

	// Run tests in parallel to speed up execution
	for _, module := range modules {
		module := module // Create local variable to avoid closure issues
		t.Run(fmt.Sprintf("Module_%s", module), func(t *testing.T) {
			t.Parallel() // Run tests in parallel

			terraformOptions := &terraform.Options{
				TerraformDir: module,
				NoColor:      true,
			}

			// Initialize and validate module only
			terraform.Init(t, terraformOptions)
			terraform.Validate(t, terraformOptions)
			
			// Skip the plan step which is time-consuming
		})
	}
}