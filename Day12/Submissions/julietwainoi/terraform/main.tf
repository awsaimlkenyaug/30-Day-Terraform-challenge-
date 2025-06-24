provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



# Create Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
   security_groups = [aws_security_group.alb_sg.id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP from anywhere"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow public access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "app" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb_sg.id]
}


# Create Launch Templates
resource "aws_launch_template" "blue" {
  name_prefix        = "blue-template"
  image_id           = var.ami_id
  instance_type      = "t2.micro"
  vpc_security_group_ids= [aws_security_group.app_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              echo "<h1>BLUE VERSION - $(hostname)</h1>" > /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
            EOF
  )
}


resource "aws_launch_template" "green" {
  name_prefix        = "green-template"
  image_id           = var.ami_id
  instance_type      = "t2.micro"
  vpc_security_group_ids= [aws_security_group.app_sg.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              echo "<h1>GREEN VERSION - $(hostname)</h1>" > /var/www/html/index.html
              sudo systemctl start httpd
              sudo systemctl enable httpd
            EOF
  )
}


# Target Groups
resource "aws_lb_target_group" "blue" {
  name     = "blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_target_group" "green" {
  name     = "green-tg"
  port     = 80
  protocol = "HTTP"
 vpc_id   = data.aws_vpc.default.id
}

# ALB
#resource "aws_lb" "app" {
 # name               = "app-lb"
  #internal           = false
  #load_balancer_type = "application"
  #subnets = data.aws_subnets.default.ids

#}

# Listener with traffic switching
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue.arn
        weight = var.active_env == "blue" ? 100 : 0
      }
      target_group {
        arn    = aws_lb_target_group.green.arn
        weight = var.active_env == "green" ? 100 : 0
      }
    }
  }
}

# Auto Scaling Groups
resource "aws_autoscaling_group" "blue" {
  name                = "blue-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.blue.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.blue.arn]
}

resource "aws_autoscaling_group" "green" {
  name                = "green-asg"
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.green.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.green.arn]
}
