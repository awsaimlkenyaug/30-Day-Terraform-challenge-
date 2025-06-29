provider "aws" {
  region = var.region
}

# ✅ Create the S3 Bucket (without deprecated versioning)
resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Terraform"
  }
}

# ✅ Enable Versioning (in separate block)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ✅ Enable Encryption (AES256)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ✅ Create the DynamoDB Table for State Locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Terraform"
  }
}
