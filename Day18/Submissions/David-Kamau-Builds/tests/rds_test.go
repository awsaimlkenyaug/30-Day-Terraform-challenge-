package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestRdsModuleValidation(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/rds-module",
	}

	terraform.Init(t, terraformOptions)
	
	// Just validate syntax, not with variables
	terraform.RunTerraformCommand(t, terraformOptions, "validate")
}

func TestRdsModulePlan(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/rds-module",
		Vars: map[string]interface{}{
			"name_prefix":        "test",
			"environment":        "test",
			"region":             "us-east-1",
			"vpc_id":            "vpc-12345678",
			"subnet_ids":        []string{"subnet-1", "subnet-2"},
			"allowed_security_groups": []string{"sg-12345678"},
			"username":          "admin",
			"password":          "test1234!",
		},
	}

	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
	
	// Verify plan contains expected resources
	assert.Contains(t, planOutput, "aws_db_instance.main")
	assert.Contains(t, planOutput, "aws_kms_key.rds")
	assert.Contains(t, planOutput, "aws_security_group.database")
	assert.Contains(t, planOutput, "aws_db_subnet_group.main")
}

func TestRdsSecuritySettings(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/rds-module",
		Vars: map[string]interface{}{
			"name_prefix":        "test",
			"environment":        "test",
			"region":             "us-east-1",
			"vpc_id":            "vpc-12345678",
			"subnet_ids":        []string{"subnet-1", "subnet-2"},
			"allowed_security_groups": []string{"sg-12345678"},
			"username":          "admin",
			"password":          "test1234!",
		},
	}

	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")

	// Verify security settings
	assert.Contains(t, planOutput, "storage_encrypted = true")
	assert.Contains(t, planOutput, "copy_tags_to_snapshot = true")
	assert.Contains(t, planOutput, "kms_key_id")
	assert.Contains(t, planOutput, "multi_az = true")
	assert.Contains(t, planOutput, "deletion_protection = true")
	assert.Contains(t, planOutput, "enabled_cloudwatch_logs_exports")
}