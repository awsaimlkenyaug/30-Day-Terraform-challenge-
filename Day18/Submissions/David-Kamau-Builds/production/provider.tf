terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# us-east-1
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

# us-west-2
provider "aws" {
  region = "us-west-2"
  alias  = "west"
}

# Default provider for backward compatibility
provider "aws" {
  region = "us-east-1"
}

# Google Cloud Platform provider
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}