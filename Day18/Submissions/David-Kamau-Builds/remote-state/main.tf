# Only create resources if deployment_mode is "deploy"
locals {
  create_resources = var.deployment_mode == "deploy" ? true : false
}

# KMS key for S3 encryption
resource "aws_kms_key" "terraform_state" {
  count                   = local.create_resources ? 1 : 0
  description             = "KMS key for Terraform state encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "terraform-state-key"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = "dkb-terraform-state"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "dkb-terraform-state"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable KMS encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = local.create_resources ? aws_kms_key.terraform_state[0].id : "dummy-key"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable logging
resource "aws_s3_bucket" "terraform_state_logs" {
  count  = local.create_resources ? 1 : 0
  bucket = "dkb-terraform-state-logs"

  tags = {
    Name        = "dkb-terraform-state-logs"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_logging" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  target_bucket = local.create_resources ? aws_s3_bucket.terraform_state_logs[0].id : "dummy-bucket"
  target_prefix = "log/"
}

# Lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  rule {
    id     = "delete_old_versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# Enable EventBridge notifications
resource "aws_s3_bucket_notification" "terraform_state" {
  count  = local.create_resources ? 1 : 0
  bucket = local.create_resources ? aws_s3_bucket.terraform_state[0].id : "dummy-bucket"

  eventbridge = true
}

# DynamoDB table for state locking
resource "aws_kms_key" "dynamodb" {
  count                   = local.create_resources ? 1 : 0
  description             = "KMS key for DynamoDB table encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "terraform-locks-key"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  count        = local.create_resources ? 1 : 0
  name         = "dkb-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = local.create_resources ? aws_kms_key.dynamodb[0].arn : "dummy-arn"
  }

  tags = {
    Name        = "dkb-terraform-locks"
    Environment = "management"
    ManagedBy   = "Terraform"
  }
}