module "east" {
  source        = "../modules/aws_instance"
  region        = "us-east-1"
  instance_name = "East-Server"
}

module "west" {
  source        = "../modules/aws_instance"
  region        = "us-west-2"
  instance_name = "West-Server"
}
