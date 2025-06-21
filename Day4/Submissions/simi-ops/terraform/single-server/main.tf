# Configure the AWS Provider
provider "aws" {
  region = "us-west-2" 
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "my_single_ec2_server" {
  ami           = "ami-04999cd8f2624f834" 
  instance_type = "t2.micro"              

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Single-Server"
  }
}


output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my_single_ec2_server.public_ip
}