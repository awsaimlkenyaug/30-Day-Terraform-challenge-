# dev/main.tf
provider "aws" {
  region  = "us-east-1"
  profile = "dev-profile"
}


module "s3" {
  source      = "../../modules/s3"
  bucket_name = "my-app-dev-bucket"

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
