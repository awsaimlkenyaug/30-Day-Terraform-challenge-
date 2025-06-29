terraform {
  backend "remote" {
    organization = "nelson_hcp"

    workspaces {
      name = "day22-single-server"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh"

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

  tags = {
    Name        = "SSH SG"
    Environment = "dev"
  }
}

resource "aws_instance" "single" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Single Server is running" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "Day22-SingleServer"
    Environment = "dev"
  }
}
