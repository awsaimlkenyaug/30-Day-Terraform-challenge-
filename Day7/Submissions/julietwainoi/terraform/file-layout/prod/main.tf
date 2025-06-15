# prod/main.tf
provider "aws" {
  region  = "us-west-2"
  profile = "prod-profile"
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "my-app-prod-bucket"

  tags = {
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}
