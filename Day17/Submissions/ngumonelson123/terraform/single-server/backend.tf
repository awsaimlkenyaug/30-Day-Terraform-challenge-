terraform {
  backend "s3" {
    bucket = "ngumo-terraform-state"
    key    = "day17/manual-test/terraform.tfstate"
    region = "us-east-1"
  }
}
