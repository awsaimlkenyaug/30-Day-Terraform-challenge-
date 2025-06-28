package test

import (
        "testing"
        "github.com/gruntwork-io/terratest/modules/terraform"
        "github.com/stretchr/testify/assert"
)

func TestTerraformSyntax(t *testing.T) {
        testCases := []struct {
                name string
                dir  string
        }{
                {"VPC Module", "../modules/vpc-module"},
                {"RDS Module", "../modules/rds-module"},
                {"EKS Module", "../modules/eks-module"},
                {"Secrets Module", "../modules/secrets-module"},
        }

        for _, tc := range testCases {
                t.Run(tc.name, func(t *testing.T) {
                        terraformOptions := &terraform.Options{
                                TerraformDir: tc.dir,
                        }
                        
                        // Test that Terraform can initialize without backend
                        terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
                        
                        // Test that Terraform syntax is valid
                        terraform.RunTerraformCommand(t, terraformOptions, "validate")
                })
        }
}

func TestVpcModuleOutputs(t *testing.T) {
        terraformOptions := &terraform.Options{
                TerraformDir: "../modules/vpc-module",
        }

        terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
        
        // Just test that plan works with variables
        planArgs := []string{
                "plan",
                "-var", "name_prefix=test",
                "-var", "environment=test",
                "-var", "region=us-east-1",
                "-var", "cidr_block=10.0.0.0/16",
                "-var", "availability_zones=[\"us-east-1a\",\"us-east-1b\"]",
        }
        
        planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, planArgs...)
        
        // Verify expected resources are planned
        expectedResources := []string{
                "aws_vpc.main",
                "aws_subnet.public",
                "aws_internet_gateway.main",
                "aws_route_table.public",
                "aws_security_group.web",
                "aws_security_group.alb",
        }
        
        for _, resource := range expectedResources {
                assert.Contains(t, planOutput, resource, "Expected resource %s not found in plan", resource)
        }
}

func TestSecurityGroupRules(t *testing.T) {
        terraformOptions := &terraform.Options{
                TerraformDir: "../modules/vpc-module",
                Vars: map[string]interface{}{
                        "name_prefix":        "test",
                        "environment":        "test",
                        "region":             "us-east-1", 
                        "cidr_block":         "10.0.0.0/16",
                        "availability_zones": []string{"us-east-1a", "us-east-1b"},
                },
        }

        terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
        planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")
        
        // Verify security group rules
        assert.Contains(t, planOutput, "from_port   = 80")
        assert.Contains(t, planOutput, "from_port   = 443") 
        assert.Contains(t, planOutput, "from_port   = 22")
}

func TestTestModeNoResources(t *testing.T) {
        terraformOptions := &terraform.Options{
                TerraformDir: "../production",
                Vars: map[string]interface{}{
                        "deployment_mode": "test",
                        "environment":    "test",
                        "db_password":    "testpassword123",  // Required variable
                        "api_key":        "testkey123",       // Required variable
                        "jwt_secret":     "testsecret123",    // Required variable
                        "gcp_project_id": "test-project-id",  // Required variable
                },
        }

        terraform.RunTerraformCommand(t, terraformOptions, "init", "-backend=false")
        planOutput := terraform.RunTerraformCommandAndGetStdout(t, terraformOptions, "plan")

        // Verify no resources are planned for creation
        assert.NotContains(t, planOutput, "# aws_vpc.main")
        assert.NotContains(t, planOutput, "# aws_db_instance.main")
        assert.NotContains(t, planOutput, "# aws_eks_cluster.main")
        assert.NotContains(t, planOutput, "# google_container_cluster.main")

        // Verify outputs show test mode values
        assert.Contains(t, planOutput, "test-mode-no-vpc")
        assert.Contains(t, planOutput, "test-mode-no-db")
        assert.Contains(t, planOutput, "test-mode-no-cluster")
}