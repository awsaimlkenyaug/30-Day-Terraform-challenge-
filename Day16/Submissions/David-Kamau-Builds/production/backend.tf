terraform {
  backend "s3" {
    bucket         = "dkb-terraform-state"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dkb-terraform-locks"
    encrypt        = true
  }
}