provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  provider    = aws.east
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example" {
  provider      = aws.east
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "East Server"
  }
}

resource "aws_vpc" "west-vpc" {
  provider   = aws.west
  cidr_block = "10.10.0.0/16"

  tags = {
    Name        = "west-vpc"
    Environment = "dr_environment"
    Terraform   = "true"
  }
}
