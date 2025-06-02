# Trigger workflow run - invalid configuration test
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"  # Invalid: Hardcoded credentials
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_s3_bucket" "invalid_bucket" {
  # Invalid: Missing required tags
  # Invalid: Public access enabled
  bucket = "my-super-public-bucket"
  acl    = "public-read"  # Security issue: Public access

  # Invalid: Incorrect block syntax
  versioning {
    enabled = true
  
  # Missing closing bracket

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Invalid: Unknown argument
  unknown_property = "this will fail"

  # Invalid: Malformed tags
  tags = {
    Environment = 
    Project = "TerraformChallenge
    Owner = shakesac
  }
} 