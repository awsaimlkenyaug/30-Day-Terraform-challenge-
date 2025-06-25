package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestHelloWorldApp(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/hello-world-app",
		VarFiles:     []string{"terraform.tfvars"},
	}

	// Init and Apply
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Example assertion (customize this based on real outputs)
	instanceType := terraform.Output(t, terraformOptions, "instance_type")
	assert.Equal(t, "t3.micro", instanceType)

	// Optionally check output IP or something else
	// publicIP := terraform.Output(t, terraformOptions, "public_ip")
	// assert.NotEmpty(t, publicIP)
}
