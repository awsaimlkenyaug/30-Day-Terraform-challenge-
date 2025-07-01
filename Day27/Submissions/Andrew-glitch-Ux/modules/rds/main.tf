resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnet_ids               # ✅ Referenced from VPC module output in envs

  tags = merge(
    var.common_tags,
    {
      Name = var.db_subnet_group_name
    }
  )
}

resource "aws_db_instance" "this" {
  identifier              = var.db_identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.security_group_id]           # ✅ From Security Group module output
  skip_final_snapshot     = true                              # 💬 Consider parameterizing for production
  publicly_accessible     = false                             # ✅ Best practice for RDS in private subnets
  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period

  tags = merge(
    var.common_tags,
    {
      Name = var.db_identifier
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
