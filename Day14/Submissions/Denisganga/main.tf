terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_west"
  region = "us-west-2"
}

# EC2 in us-east-1
resource "aws_instance" "east_instance" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  provider      = aws.us_east

  tags = {
    Name = "EastInstance"
  }
}

# EC2 in us-west-2
resource "aws_instance" "west_instance" {
  ami           = "ami-0892d3c7ee96c0bf7"
  instance_type = "t2.micro"
  provider      = aws.us_west

  tags = {
    Name = "WestInstance"
  }
}

