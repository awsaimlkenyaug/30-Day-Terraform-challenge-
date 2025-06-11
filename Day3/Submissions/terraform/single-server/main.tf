provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "web_server" {
  ami           = "ami-0a7d80731ae1b2435"
  instance_type = "t2.micro"
  

  tags = {
    Name = "WebServer"
  }
}
