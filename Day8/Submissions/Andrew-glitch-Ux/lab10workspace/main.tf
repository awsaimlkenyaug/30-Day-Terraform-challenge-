provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "workspace_demo" {
  bucket = "workspace-demo-${terraform.workspace}"
}

resource "aws_s3_bucket_public_access_block" "workspace_demo_block" {
  bucket                  = aws_s3_bucket.workspace_demo.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
