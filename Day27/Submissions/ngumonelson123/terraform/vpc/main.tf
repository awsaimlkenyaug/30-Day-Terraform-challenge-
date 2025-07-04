module "vpc_east" {
  source     = "../modules/vpc"
  providers  = {
    aws = aws.us_east
  }

  cidr_block = "10.0.0.0/16"
  name       = "vpc-east"
  azs        = ["us-east-1a", "us-east-1b"]
}

module "vpc_west" {
  source     = "../modules/vpc"
  providers  = {
    aws = aws.us_west
  }

  cidr_block = "10.1.0.0/16"
  name       = "vpc-west"
  azs        = ["us-west-2a", "us-west-2b"]
}
