terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "web" {
  provider = aws.aws_east
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
