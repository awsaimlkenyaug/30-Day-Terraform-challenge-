terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# East Coast provider (us-east-1)
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

# West Coast provider (us-west-2)
provider "aws" {
  region = "us-west-2"
  alias  = "west"
}

# Default provider (us-east-1) for backward compatibility
provider "aws" {
  region = "us-east-1"
}