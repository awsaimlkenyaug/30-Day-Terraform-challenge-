terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}

# Example resource (your real infrastructure)
resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket-123456"
}
