# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}
resource "aws_security_group" "ec2_sg" {
  name        = "web-server-sg"
  description = "Allow web traffic and SSH access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
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
    Name = "web-server-security-group"
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-04999cd8f2624f834" 
  instance_type = "t2.micro"             
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from Terraform 30 Day Challenge</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServer"
  }
}

output "public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}