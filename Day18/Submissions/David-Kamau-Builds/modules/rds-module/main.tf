# KMS key for RDS encryption
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-rds-key"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# Database Security Group
resource "aws_security_group" "database" {
  name        = "${var.name_prefix}-${var.environment}-db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.allowed_security_groups
    description     = "Allow MySQL access from application servers"
  }

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-db-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name        = "${var.name_prefix}-${var.environment}-db-subnet-group"
  subnet_ids  = var.subnet_ids
  description = "Database subnet group for ${var.name_prefix}-${var.environment}"

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-db-subnet-group"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier           = "${var.name_prefix}-${var.environment}-db"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = replace("${var.name_prefix}${var.environment}", "-", "")
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  # Enhanced security settings
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds.arn
  copy_tags_to_snapshot   = true
  backup_retention_period = 7
  multi_az                = true
  deletion_protection     = true
  
  # Enable IAM authentication
  iam_database_authentication_enabled = true
  
  # Enable enhanced monitoring
  monitoring_interval = 30
  monitoring_role_arn = aws_iam_role.rds_monitoring.arn
  
  # Enable automatic minor version upgrades
  auto_minor_version_upgrade = true

  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-db"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
    Project     = "MultiRegionDeployment"
  }
}

# IAM role for RDS enhanced monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "${var.name_prefix}-${var.environment}-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.name_prefix}-${var.environment}-rds-monitoring-role"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Attach the required policy for RDS enhanced monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}