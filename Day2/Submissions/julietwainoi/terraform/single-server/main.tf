provider "aws" {
  region = "us-east-1"  # or your preferred region
}

resource "aws_instance" "single" {
  ami           = "ami-0953476d60561c955" 
  instance_type = "t2.micro"

  tags = {
    Name = "SingleServer"
  }
}
