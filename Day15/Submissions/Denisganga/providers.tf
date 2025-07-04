provider "aws" {
  alias  = "aws_east"
  region = "us-east-1"
}

provider "google" {
  alias  = "gcp"
  project = var.gcp_project
  region  = var.gcp_region
}
