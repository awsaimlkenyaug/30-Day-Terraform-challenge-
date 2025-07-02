package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestALBModule(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../terraform/modules/alb",
		Vars: map[string]interface{}{
			"environment":       "test",
			"name_prefix":       "test-web",
			"security_group_id": "sg-12345678",
			"tags": map[string]string{
				"Environment": "test",
				"Module":      "alb",
			},
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndPlan(t, terraformOptions)
	
	// Validate that the plan contains expected resources
	planOutput := terraform.Plan(t, terraformOptions)
	assert.Contains(t, planOutput, "aws_lb.web")
	assert.Contains(t, planOutput, "aws_lb_target_group.web")
	assert.Contains(t, planOutput, "aws_lb_listener.web")
}