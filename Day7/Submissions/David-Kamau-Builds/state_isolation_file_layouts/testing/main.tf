provider "aws" {
  region = "us-east-1"
}

module "s3bucket" {
  source      = "../modules/s3bucket"
  bucket_name = "tf-filelayout-testing-20250602"
  tags = {
    Environment = "testing"
    Owner       = "David Kamau"
  }
}
