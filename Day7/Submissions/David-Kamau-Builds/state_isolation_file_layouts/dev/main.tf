provider "aws" {
  region = "us-east-1"
}

module "s3bucket" {
  source      = "../modules/s3bucket"
  bucket_name = "tf-filelayout-dev-20250602"
  tags = {
    Environment = "dev"
    Owner       = "David Kamau"
  }
}
