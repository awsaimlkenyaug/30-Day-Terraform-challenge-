resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

module "single_server" {
  source        = "../../modules/ec2"
  ami_id        = "ami-07d0cf3af28718ef8"
  instance_type = "t2.micro"
  name          = "Auto-Networked-Instance"
  subnet_id     = aws_subnet.main.id
}
