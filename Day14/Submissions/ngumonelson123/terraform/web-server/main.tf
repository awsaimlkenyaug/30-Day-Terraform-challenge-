provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

provider "aws" {
  alias  = "uswest"
  region = "us-west-2"
}

# Fetch latest Amazon Linux 2 AMI in us-west-2
data "aws_ssm_parameter" "ami_uswest" {
  name     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  provider = aws.uswest
}

# VPC in us-east-1
resource "aws_vpc" "useast_vpc" {
  provider   = aws.useast
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "VPC-East"
  }
}

# EC2 instance in us-west-2
resource "aws_instance" "uswest_instance" {
  provider      = aws.uswest
  ami           = data.aws_ssm_parameter.ami_uswest.value
  instance_type = "t2.micro"

  tags = {
    Name = "WebServer-West"
  }
}
