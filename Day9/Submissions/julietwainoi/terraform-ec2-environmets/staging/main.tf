module "ec2_staging" {
  source        = "git::https://github.com/julietwainoi/terraform-aws-ec2-instance-module.git?ref=v1.1.0"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.small"
  tags = {
    Name = "StagingInstance"
    Env  = "staging"
  }
}
