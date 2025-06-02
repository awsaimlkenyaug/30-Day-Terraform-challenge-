provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tryout" {
  bucket = "tf-state-dwk2025"

  tags = {
    Environment = "test"
    Owner       = "David Kamau"
  }
}
