provider "aws" {
  region = "us-east-1"
}

resource "random_id" "suffix" {
  keepers = {
    workspace = terraform.workspace
  }
  byte_length = 4
}

resource "aws_s3_bucket" "wrkspceIsolation" {
  bucket = "tf-state-iso-${terraform.workspace}-${random_id.suffix.hex}"

  tags = {
    Environment = terraform.workspace
    Owner       = "David Kamau"
  }
}

resource "aws_s3_bucket_acl" "wrkspceIsolation_acl" {
  bucket = aws_s3_bucket.wrkspceIsolation.bucket
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "wrkspceIsolation_versioning" {
  bucket = aws_s3_bucket.wrkspceIsolation.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
