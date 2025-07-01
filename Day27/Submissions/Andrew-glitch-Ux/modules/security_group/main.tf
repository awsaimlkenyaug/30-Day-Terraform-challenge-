resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.security_group_description
vpc_id         = var.vpc_id

  ingress {
    description = var.sg_ingress_description
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = var.security_group_name
    }
  )
}

