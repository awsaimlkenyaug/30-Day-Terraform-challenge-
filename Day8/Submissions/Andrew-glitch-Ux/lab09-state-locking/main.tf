provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "lab09_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}
