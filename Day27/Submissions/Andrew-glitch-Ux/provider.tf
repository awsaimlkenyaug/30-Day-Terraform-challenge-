provider "aws" {
  region  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"  # Use latest 5.x version known to support Windows
    }
  }
}