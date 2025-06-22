package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestPostDeployValidation(t *testing.T) {
	// Test production configuration
	terraformOptions := &terraform.Options{
		TerraformDir: "../production",
		NoColor:      true,
	}

	// Initialize and validate production config
	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	
	// Run plan and capture output
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
	
	// Verify all required resources are present
	requiredResources := []string{
		"module.vpc",
		"module.rds",
		"module.eks",
		"module.secrets",
	}
	
	for _, resource := range requiredResources {
		assert.Contains(t, planOutput, resource, "Required module %s not found in production configuration", resource)
	}
	
	// Verify module dependencies are correctly ordered
	// VPC should be created before RDS and EKS
	vpcIndex := findInString(planOutput, "module.vpc")
	rdsIndex := findInString(planOutput, "module.rds")
	eksIndex := findInString(planOutput, "module.eks")
	
	assert.True(t, vpcIndex < rdsIndex, "VPC module should be created before RDS module")
	assert.True(t, vpcIndex < eksIndex, "VPC module should be created before EKS module")
}

func TestSecurityCompliance(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../production",
		NoColor:      true,
	}

	// Initialize and get plan output
	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
	
	// Security compliance checks
	securityChecks := []string{
		"enable_encryption",
		"kms_key",
		"encrypted",
		"security_group",
		"iam_role",
	}
	
	for _, check := range securityChecks {
		assert.Contains(t, planOutput, check, "Security feature %s not found in configuration", check)
	}
}

func TestResourceTags(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../production",
		NoColor:      true,
	}

	// Initialize and get plan output
	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
	
	// Required tags
	requiredTags := []string{
		"Environment",
		"Project",
		"ManagedBy",
	}
	
	for _, tag := range requiredTags {
		assert.Contains(t, planOutput, tag, "Required tag %s not found in configuration", tag)
	}
}

// Helper function to find string position
func findInString(s, substr string) int {
	for i := 0; i < len(s); i++ {
		if len(s[i:]) >= len(substr) && s[i:i+len(substr)] == substr {
			return i
		}
	}
	return len(s)
}