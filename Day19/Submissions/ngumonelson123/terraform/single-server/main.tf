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

resource "aws_instance" "example" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"

  tags = {
    Name = "Day19Server"
  }
}
# Triggering Day 19 run
