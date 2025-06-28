package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRdsModule(t *testing.T) {
	t.Skip("Skipping test that requires real AWS resources")
	
	// For CI/CD, we'll use plan testing instead of apply
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/rds-module",
		Vars: map[string]interface{}{
			"name_prefix": "test",
			"environment": "test",
			"region":      "us-east-1",
			"username":    "testuser",
			"password":    "testpassword",
			"vpc_id":      "vpc-12345",
			"subnet_ids":  []string{"subnet-12345", "subnet-67890"},
		},
	})

	// Validate the module can be initialized
	terraform.Init(t, terraformOptions)
	
	// Run plan and check that it would create the expected resources
	planOutput := terraform.Plan(t, terraformOptions)
	
	// Verify plan contains expected resources
	assert.Contains(t, planOutput, "aws_db_instance.main")
	assert.Contains(t, planOutput, "aws_db_subnet_group.main")
	assert.Contains(t, planOutput, "aws_security_group.database")
}