provider "aws" {
  region = "us-west-2"
}

module "ec2_dev" {
  source        = "git::https://github.com/julietwainoi/terraform-aws-ec2-instance-module.git?ref=v1.0.0"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "DevInstance"
    Env  = "dev"
  }
}
