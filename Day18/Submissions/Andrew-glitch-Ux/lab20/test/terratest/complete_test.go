package test

import (
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestHelloWorldInfra(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples",
		VarFiles:     []string{"terraform.tfvars"},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	assert.True(t, strings.HasPrefix(vpcID, "vpc-"))

	publicSubnetIDs := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
	assert.Equal(t, 2, len(publicSubnetIDs))

	albArn := terraform.Output(t, terraformOptions, "alb_arn")
	albDNS := terraform.Output(t, terraformOptions, "alb_dns_name")
	targetGroupArn := terraform.Output(t, terraformOptions, "alb_target_group_arn")

	assert.True(t, strings.HasPrefix(albArn, "arn:aws:elasticloadbalancing:"))
	assert.True(t, strings.Contains(albDNS, ".elb."))
	assert.True(t, strings.HasPrefix(targetGroupArn, "arn:aws:elasticloadbalancing:"))

	asgName := terraform.Output(t, terraformOptions, "asg_name")
	launchTemplateID := terraform.Output(t, terraformOptions, "launch_template_id")
	launchTemplateName := terraform.Output(t, terraformOptions, "launch_template_name")

	assert.Contains(t, asgName, "hello-world-app")
	assert.True(t, strings.HasPrefix(launchTemplateID, "lt-"))
	assert.Contains(t, launchTemplateName, "hello-world-app")

	url := "http://" + albDNS
	expectedStatus := 200
	expectedBodySubstring := "Hello, World"

	t.Log("Sending HTTP GET to:", url)
	http_helper.HttpGetWithRetry(t, url, nil, expectedStatus, expectedBodySubstring, 30, 10*time.Second)

	t.Log("End-to-End test passed: HTTP reachable and content OK.")
}
