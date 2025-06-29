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

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnet in that VPC
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "example" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  subnet_id     = tolist(data.aws_subnet_ids.default.ids)[0]  # pick the first subnet

  tags = {
    Name = "Day19Server"
  }
}
