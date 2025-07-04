# main.tf
module "aws_infra" {
  source   = "./modules/aws"
  providers = {
    aws = aws.aws_provider
  }
}

module "gcp_infra" {
  source   = "./modules/gcp"
  providers = {
    google = google.gcp_provider
  }
}
