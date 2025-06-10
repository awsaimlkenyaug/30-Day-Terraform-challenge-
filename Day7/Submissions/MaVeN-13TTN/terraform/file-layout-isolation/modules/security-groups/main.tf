# Security Group Module for File Layout Isolation

resource "aws_security_group" "web" {
  name_prefix = "${var.environment}-web-sg"
  vpc_id      = var.vpc_id
  description = "Security group for web servers in ${var.environment}"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-web-sg"
      Type = "SecurityGroup"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Database Security Group (if needed)
resource "aws_security_group" "database" {
  count = var.create_database_sg ? 1 : 0

  name_prefix = "${var.environment}-db-sg"
  vpc_id      = var.vpc_id
  description = "Security group for database servers in ${var.environment}"

  ingress {
    description     = "MySQL/Aurora"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    description     = "PostgreSQL"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-db-sg"
      Type = "SecurityGroup"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
