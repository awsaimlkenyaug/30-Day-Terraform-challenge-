terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::111122223333:role/TerraformProdRole"
    session_name = "tf-prod"
  }
}

resource "aws_s3_bucket" "bucket_east" {
  provider = aws.us_east
  bucket   = "my-bucket-east"
}

resource "aws_s3_bucket" "bucket_west" {
  provider = aws.us_west
  bucket   = "my-bucket-west"
}

resource "aws_s3_bucket" "bucket_prod" {
  provider = aws.prod
  bucket   = "my-prod-account-bucket"
}
