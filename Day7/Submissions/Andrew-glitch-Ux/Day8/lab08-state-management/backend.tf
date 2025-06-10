terraform {
  backend "s3" {
    bucket         = "andrew-tf-lab08-bucket"
    key            = "lab08/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "andrew-tf-lab08-lock"
  }
}
