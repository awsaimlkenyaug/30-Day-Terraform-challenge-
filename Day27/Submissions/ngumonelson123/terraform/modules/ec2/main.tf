resource "aws_security_group" "app_sg" {
  provider = aws.us_east
  name        = "app-sg"
  description = "Allow HTTP"
  vpc_id = var.vpc_id

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

resource "aws_launch_template" "app" {
  provider            = aws.us_east
  name_prefix         = "app-launch-"
  image_id            = "ami-0fb653ca2d3203ac1" # Ubuntu 22.04 for us-east-2
  instance_type       = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "<h1>Deployed via Terraform - $(hostname)</h1>" > /var/www/html/index.html
              systemctl restart nginx
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "AppInstance"
    }
  }
}