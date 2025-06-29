terraform {
  backend "remote" {
    organization = "nelson_hcp"

    workspaces {
      name = "day19-single-server"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch first available subnet in the default VPC
data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  # Optional filter to narrow to public subnet
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.default.id

  tags = {
    Name = "Day19Server"
  }
}
