# GCP Module

This module deploys Google Cloud Platform resources including a VPC network, subnet, and GKE cluster.

## Important Note

**This module requires a Google Cloud Platform account and project.**

If you don't have a GCP account, this module will not work. The module is included for demonstration purposes and to show multi-cloud capabilities.

## Resources Created

- VPC Network
- Subnet with private IP Google access and flow logs
- Firewall rules
- GKE cluster with security best practices
- GKE node pool

## Usage

```hcl
module "gcp_infrastructure" {
  source = "../modules/gcp-module"

  name_prefix              = "my-project"
  environment              = "prod"
  region                   = "us-central1"
  node_count               = 2
  authorized_networks_cidr = "10.0.0.0/8"
  domain                   = "example.com"  # For Google Groups RBAC
}
```

## Security Features

This module implements several security best practices:

- Private cluster configuration
- Binary authorization
- Network policy
- Secure Boot for nodes
- Automatic node repair and upgrades
- GKE Metadata Server
- Release channel configuration

## Testing Without GCP Account

For testing without a GCP account:

1. Set `deployment_mode = "test"` in the root module
2. The module will not create any resources in test mode
3. CI/CD pipelines will run with placeholder values

## Limitations

- Requires GCP project ID and credentials
- Uses placeholder values for Google Groups RBAC
- May require additional IAM permissions
- Some features require GCP organization policies