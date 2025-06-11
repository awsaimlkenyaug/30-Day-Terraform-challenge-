resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from Terraform 30 Day Challenge: Day 8</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServer"
  }
}