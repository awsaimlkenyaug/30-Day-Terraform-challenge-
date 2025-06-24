module "aws_vm" {
  source = "./modules/aws_vm"
  providers = {
    aws = aws.aws_east
  }
}

module "gcp_vm" {
  source = "./modules/gcp_vm"
  providers = {
    google = google.gcp
  }
}
