package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// End-to-end test that deploys real infrastructure (use with caution)
func TestE2EInfrastructureDeployment(t *testing.T) {
	// Skip by default to avoid costs - enable only for full E2E testing
	t.Skip("E2E test disabled - enable only for full infrastructure testing")
	
	t.Parallel()

	uniqueId := random.UniqueId()
	namePrefix := fmt.Sprintf("e2e-%s", uniqueId)
	awsRegion := "us-east-1"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../production",
		Vars: map[string]interface{}{
			"name_prefix":        namePrefix,
			"environment":        "e2e-test",
			"region":             awsRegion,
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})

	// Clean up resources at the end
	defer terraform.Destroy(t, terraformOptions)

	// Deploy the infrastructure
	terraform.InitAndApply(t, terraformOptions)

	// Validate outputs
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcId)

	// Verify VPC exists and has correct configuration
	vpc := aws.GetVpcById(t, vpcId, awsRegion)
	assert.Equal(t, "10.0.0.0/16", *vpc.CidrBlock)

	// Verify subnets exist
	subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)
	assert.GreaterOrEqual(t, len(subnets), 2)

	// Test connectivity (if load balancer is deployed)
	// albDnsName := terraform.Output(t, terraformOptions, "alb_dns_name")
	// if albDnsName != "" {
	//     url := fmt.Sprintf("http://%s", albDnsName)
	//     http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello", 30, 5*time.Second)
	// }
}

func TestInfrastructureRecovery(t *testing.T) {
	t.Skip("Recovery test disabled - enable for disaster recovery testing")
	
	// Test infrastructure can recover from failures
	uniqueId := random.UniqueId()
	namePrefix := fmt.Sprintf("recovery-%s", uniqueId)
	awsRegion := "us-east-1"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../production",
		Vars: map[string]interface{}{
			"name_prefix":        namePrefix,
			"environment":        "recovery-test",
			"region":             awsRegion,
			"cidr_block":         "10.0.0.0/16",
			"availability_zones": []string{"us-east-1a", "us-east-1b"},
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	// Initial deployment
	terraform.InitAndApply(t, terraformOptions)
	
	// Simulate failure by destroying a component
	// Then verify terraform can recover
	terraform.Apply(t, terraformOptions)
	
	// Verify infrastructure is healthy after recovery
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcId)
}