terraform {
  backend "s3" {
    bucket         = "tfstate-ngumonelson123"
    key            = "day16/single-server/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
