provider "aws" {
  region = "eu-north-1"
}
resource "aws_instance" "example" {
  ami           = "ami-0c1ac8a41498c1a9c" 
  instance_type = "t3.micro"
  subnet_id     = "subnet-0b313224ecb43decc"
}