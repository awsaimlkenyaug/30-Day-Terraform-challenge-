provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-006b4a3ad5f56fbd6"
  instance_type = var.instance_type

  tags = {
    Name = "Lab07-WebServer"
  }
}
