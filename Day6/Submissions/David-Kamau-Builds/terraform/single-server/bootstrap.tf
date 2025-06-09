resource "aws_s3_bucket" "state_bucket" {
  bucket = "day-6-test-tf-state-single-server"

  tags = {
    Name        = "tf-state-bucket-single-server"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "state_bucket_acl" {
  bucket = aws_s3_bucket.state_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = "day-6-test-locks-single-server"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "tf-locks-table-single-server"
    Environment = var.environment
  }
}
