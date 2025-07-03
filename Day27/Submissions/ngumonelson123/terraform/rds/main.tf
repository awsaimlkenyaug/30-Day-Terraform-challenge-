# SECURITY GROUP FOR RDS
resource "aws_security_group" "rds_sg" {
  provider = aws.us_east
  name        = "rds-sg"
  description = "Allow DB traffic from VPC"
  vpc_id      = var.vpc_east_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Only allow from VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

# SUBNET GROUP FOR RDS PRIMARY
resource "aws_db_subnet_group" "rds_primary_subnets" {
  provider   = aws.us_east
  name       = "rds-subnet-group-east"
  subnet_ids = var.private_subnets_east
  tags = {
    Name = "RDS Primary Subnet Group"
  }
}

# PRIMARY RDS INSTANCE
resource "aws_db_instance" "primary" {
  provider               = aws.us_east
  identifier             = "rds-primary"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "mydb"
  username               = "dbadmin"
  password               = "Passw0rd123!"
  skip_final_snapshot    = true
  publicly_accessible    = false  # Private subnet, no public access
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_primary_subnets.name
  multi_az               = true
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  tags = {
    Name = "RDS Primary"
  }
}

# SECURITY GROUP FOR RDS REPLICA
resource "aws_security_group" "rds_replica_sg" {
  provider = aws.us_west
  name        = "rds-replica-sg"
  description = "Allow DB traffic for replica from VPC"
  vpc_id      = var.vpc_west_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]  # Only allow from VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-replica-security-group"
  }
}

# SUBNET GROUP FOR REPLICA
resource "aws_db_subnet_group" "rds_replica_subnets" {
  provider   = aws.us_west
  name       = "rds-subnet-group-west"
  subnet_ids = var.private_subnets_west
  tags = {
    Name = "RDS Replica Subnet Group"
  }
}

# READ REPLICA RDS
resource "aws_db_instance" "replica" {
  provider               = aws.us_west
  identifier             = "rds-replica"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  publicly_accessible    = false  # Private subnet, no public access
  replicate_source_db    = aws_db_instance.primary.arn
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.rds_replica_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_replica_sg.id]
  tags = {
    Name = "RDS Read Replica"
  }
}
