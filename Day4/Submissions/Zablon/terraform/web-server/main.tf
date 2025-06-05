# configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# retrieve the latest AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


# define a Security Group to allow inbound traffic
resource "aws_security_group" "firewall" {
  name = "instance_security_group"
  ingress {
    to_port     = var.server_port
    from_port   = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# launch an EC2 instance 
resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.firewall.id]
  user_data = templatefile("${path.module}/user_data.sh", {
    server_port = var.server_port
  })
  user_data_replace_on_change = true


  tags = {
    "Name" = "WebServer"
  }

}
