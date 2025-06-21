provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default_az1" {
  availability_zone = "us-east-2a" # Replace with your desired AZ
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  default_for_az = true
}

resource "aws_security_group" "instance" {
  name        = "terraform-example-instance"
  description = "Allow inbound traffic on port 8080"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting this to your IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami                         = "ami-0fb653ca2d3203ac1" # Replace with a valid AMI for us-east-2
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.instance.id]
  subnet_id                   = data.aws_subnet.default_az1.id
  user_data                   = <<-EOF
    #!/bin/bash
    # Install busybox (if not already present)
    apt-get update -y
    apt-get install -y busybox

    # Create index.html
    echo "Hello, World from Terraform!" > /var/www/html/index.html

    # Start web server, redirecting output to a log file
    nohup busybox httpd -f -p 8080 -h /var/www/html/ > /tmp/httpd.log 2>&1 &

    echo "Web server started.  Check /tmp/httpd.log for errors." > /tmp/startup.log
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "terraform-example"
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}
