provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "lab08_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "Lab08-Bucket"
  }
}
