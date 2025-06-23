resource "aws_db_instance" "this" {
allocated_storage = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier            = var.name
  username             = var.username
  password             = var.password
  port                 = var.port
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "this" {
  name       = "db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "db-subnet-group"
  }
}
