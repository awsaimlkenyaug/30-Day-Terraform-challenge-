terraform {
  backend "s3" {
    bucket  = "simi-ops-terraform-state"
    key     = "web-server/terraform.tfstate"
    region  = "us-west-2"
    encrypt = true
  }
}