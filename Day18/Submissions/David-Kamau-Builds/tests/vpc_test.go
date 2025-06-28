package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVpcModulePlan(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/vpc-module",
		Vars: map[string]interface{}{
			"name_prefix":        "test",
			"environment":        "test",
			"region":             "us-east-1",
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
			"allowed_cidr_blocks": []string{"192.168.1.0/24"},
			"allowed_egress_cidr_blocks": []string{"10.0.0.0/8"},
			"alb_arn": "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/test/test",
			"waf_web_acl_arn": "arn:aws:wafv2:us-east-1:123456789012:regional/webacl/test/test",
		},
	}

	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
	
	// Verify plan contains expected resources
	assert.Contains(t, planOutput, "aws_vpc.main")
	assert.Contains(t, planOutput, "aws_subnet.public")
	assert.Contains(t, planOutput, "aws_internet_gateway.main")
	assert.Contains(t, planOutput, "aws_route_table.public")
	assert.Contains(t, planOutput, "aws_security_group.web")
	assert.Contains(t, planOutput, "aws_kms_key.log_group_key")
	assert.Contains(t, planOutput, "aws_cloudwatch_log_group.vpc_flow_logs")
	assert.Contains(t, planOutput, "aws_wafv2_web_acl_association.alb")
}

func TestVpcModuleValidation(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/vpc-module",
	}

	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	terraform.RunTerraformCommand(t, terraformOptions, "validate")
}

func TestVpcSecuritySettings(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/vpc-module",
		Vars: map[string]interface{}{
			"name_prefix":        "test",
			"environment":        "test",
			"region":             "us-east-1",
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
			"allowed_cidr_blocks": []string{"192.168.1.0/24"},
			"allowed_egress_cidr_blocks": []string{"10.0.0.0/8"},
			"alb_arn": "arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/test/test",
			"waf_web_acl_arn": "arn:aws:wafv2:us-east-1:123456789012:regional/webacl/test/test",
		},
	}

	terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
	planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")

	// Verify security settings
	assert.Contains(t, planOutput, "map_public_ip_on_launch = false")
	assert.Contains(t, planOutput, "kms_key_id")
	assert.Contains(t, planOutput, "retention_in_days = 365")
	assert.NotContains(t, planOutput, "cidr_blocks = [\"0.0.0.0/0\"]")
}