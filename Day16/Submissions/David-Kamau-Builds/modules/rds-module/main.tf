variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID of the VPC where the database will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the database can be placed"
  type        = list(string)
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
    security_groups = []  # Will be updated by the application security groups
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
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = replace("${var.name_prefix}${var.environment}", "-", "")
  username            = var.username
  password            = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  storage_encrypted   = true
  
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  
  tags = {
    Name        = "${var.name_prefix}-${var.environment}-db"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = var.region
    Project     = "MultiRegionDeployment"
  }
}

# Outputs
output "db_instance_endpoint" {
  description = "The connection endpoint for the database"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_id" {
  description = "The ID of the database instance"
  value       = aws_db_instance.main.id
}

output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.database.id
}