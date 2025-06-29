# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_app_bucket" {
  bucket = "ngumo-app-bucket-${random_id.bucket_id.hex}"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
