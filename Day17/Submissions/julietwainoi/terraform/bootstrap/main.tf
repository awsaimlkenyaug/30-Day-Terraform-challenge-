provider "aws" {
  region = "us-west-2"

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "TerraformStateBucket"
    Environment = "Bootstrap"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "TerraformLockTable"
    Environment = "Bootstrap"
  }
}
}