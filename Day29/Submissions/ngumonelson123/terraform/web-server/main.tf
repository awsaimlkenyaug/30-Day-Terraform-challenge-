provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "web" {
  name   = "allow-web"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_instance" "web" {
  ami                         = "ami-0c7217cdde317cfec"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Deployed with Terraform</h1><p>Server is running successfully!</p>" > /var/www/html/index.html
              systemctl restart apache2
              EOF

  tags = {
    Name = "WebServer"
  }
}

resource "aws_eip" "web" {
  domain = "vpc"
  tags = {
    Name = "WebServer-EIP"
  }
}

resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
  depends_on    = [aws_instance.web]
}

output "web_server_ip" {
  value = aws_eip.web.public_ip
  description = "Public IP address of the web server"
}
