package test

import (
  "testing"
  "strings"

  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestHelloWorldInfra(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../../examples",


    // This assumes terraform.tfvars is in the example folder
    VarFiles: []string{"terraform.tfvars"},
  }

  // Deploy the infrastructure
  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)

  // VPC Assertions
  vpcID := terraform.Output(t, terraformOptions, "vpc_id")
  assert.True(t, strings.HasPrefix(vpcID, "vpc-"))

  publicSubnetIDs := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
  assert.Equal(t, 2, len(publicSubnetIDs))

  // ALB Assertions
  albArn := terraform.Output(t, terraformOptions, "alb_arn")
  albDNS := terraform.Output(t, terraformOptions, "alb_dns_name")
  assert.True(t, strings.HasPrefix(albArn, "arn:aws:elasticloadbalancing:"))
  assert.True(t, strings.Contains(albDNS, ".elb."))

  targetGroupArn := terraform.Output(t, terraformOptions, "target_group_arn")
  assert.True(t, strings.HasPrefix(targetGroupArn, "arn:aws:elasticloadbalancing:"))

  // ASG Assertions
  asgName := terraform.Output(t, terraformOptions, "asg_name")
  assert.Contains(t, asgName, "hello-world-app")

  launchTemplateID := terraform.Output(t, terraformOptions, "launch_template_id")
  assert.True(t, strings.HasPrefix(launchTemplateID, "lt-"))

  launchTemplateName := terraform.Output(t, terraformOptions, "launch_template_name")
  assert.Contains(t, launchTemplateName, "hello-world-app")
} 
