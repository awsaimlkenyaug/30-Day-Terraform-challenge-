resource "aws_security_group" "alb_sg" {
  provider    = aws.us_east
  name        = "alb-sg"
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

resource "aws_lb" "app_alb" {
  provider            = aws.us_east
  name                = "app-alb"
  internal            = false
  load_balancer_type  = "application"
  subnets             = var.public_subnets
  security_groups     = [aws_security_group.alb_sg.id]

  tags = {
    Name = "AppALB"
  }
}

resource "aws_lb_target_group" "app_tg" {
  provider = aws.us_east
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id


  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  provider          = aws.us_east
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_autoscaling_group" "app_asg" {
  provider             = aws.us_east
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier = var.public_subnets



  health_check_type    = "EC2"

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "AppASG"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_tg_attachment" {
  provider               = aws.us_east
  autoscaling_group_name = aws_autoscaling_group.app_asg.name
  lb_target_group_arn   = aws_lb_target_group.app_tg.arn
}
