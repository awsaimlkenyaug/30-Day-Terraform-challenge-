provider "aws" {
  region = "us-east-1"
}

module "s3bucket" {
  source      = "../modules/s3bucket"
  bucket_name = "tf-filelayout-production-20250602"
  tags = {
    Environment = "production"
    Owner       = "David Kamau"
  }
}
