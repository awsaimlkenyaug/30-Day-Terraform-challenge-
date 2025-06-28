# GCP Module

This module creates Google Cloud Platform infrastructure including VPC network, subnet, and GKE cluster.

## Features

- Creates a VPC network in GCP
- Sets up a subnet with proper IP addressing
- Deploys a Google Kubernetes Engine (GKE) cluster
- Configures firewall rules for secure access

## Usage

```hcl
module "gcp_infrastructure" {
  source = "./modules/gcp-module"

  name_prefix = "my-app"
  environment = "prod"
  region      = "us-central1"
  node_count  = 2
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| google | ~> 4.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| name_prefix | Prefix to be used for resource names | string | yes |
| environment | Environment name | string | yes |
| region | GCP region | string | yes |
| node_count | Number of nodes in the GKE cluster | number | yes |

## Outputs

| Name | Description |
|------|-------------|
| network_name | The name of the VPC network |
| subnet_name | The name of the subnet |
| cluster_name | The name of the GKE cluster |
| cluster_endpoint | The endpoint for the GKE cluster |

## Tags

All resources are labeled with:
- Name
- Environment
- ManagedBy = "Terraform"