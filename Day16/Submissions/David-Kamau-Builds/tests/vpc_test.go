package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVpcModule(t *testing.T) {
	t.Skip("Skipping test that requires real AWS resources")
	
	// For CI/CD, we'll use plan testing instead of apply
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/vpc-module",
		Vars: map[string]interface{}{
			"name_prefix":        "test",
			"environment":        "test",
			"region":             "us-east-1",
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
		},
	})

	// Validate the module can be initialized
	terraform.Init(t, terraformOptions)
	
	// Run plan and check that it would create the expected resources
	planOutput := terraform.Plan(t, terraformOptions)
	
	// Verify plan contains expected resources
	assert.Contains(t, planOutput, "aws_vpc.main")
	assert.Contains(t, planOutput, "aws_subnet.public")
	assert.Contains(t, planOutput, "aws_internet_gateway.main")
	assert.Contains(t, planOutput, "aws_route_table.public")
	assert.Contains(t, planOutput, "aws_security_group.web")
}