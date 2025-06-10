terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Data source to validate AWS connection
data "aws_caller_identity" "current" {}

# Output to verify configuration
output "current_user" {
  value = data.aws_caller_identity.current.user_id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
