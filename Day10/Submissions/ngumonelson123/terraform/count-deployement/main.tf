provider "aws" {
  region = "us-east-1"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "deploy_ec2" {
  type    = bool
  default = true
}

resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.10.1.0/24"
}

resource "aws_security_group" "web" {
  name   = "web-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "multi" {
  count                     = var.deploy_ec2 ? var.instance_count : 0
  ami                       = ""
  instance_type             = "t2.micro"
  subnet_id                 = aws_subnet.main.id
  vpc_security_group_ids    = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "loop-instance-${count.index}"
  }
}
