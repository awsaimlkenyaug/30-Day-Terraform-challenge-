package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformSingleServer(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../",

    Vars: map[string]interface{}{},
  }

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)

  instanceID := terraform.Output(t, terraformOptions, "instance_id")
  assert.NotEmpty(t, instanceID)
}
