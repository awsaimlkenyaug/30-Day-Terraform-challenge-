data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "single_server_sg" {
  name        = "single-server-sg-${var.environment}"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

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

  tags = {
    Name        = "single-server-sg"
    Environment = var.environment
  }
}

resource "aws_instance" "single" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.single_server_sg.id]
  subnet_id                   = element(data.aws_subnet_ids.default.ids, 0)
  associate_public_ip_address = true

  tags = {
    Name        = "single-server-instance"
    Environment = var.environment
  }
}

resource "aws_eip" "single_eip" {
  instance = aws_instance.single.id

  tags = {
    Name        = "single-server-eip"
    Environment = var.environment
  }
}
