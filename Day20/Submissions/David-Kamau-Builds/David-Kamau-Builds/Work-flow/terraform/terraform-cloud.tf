# Terraform Cloud Configuration
terraform {
  cloud {
    organization = "David-Kamau-Builds"  # Replace with your actual HCP Terraform organization

    workspaces {
      name = "web-server-prod"
    }
  }
}

# Variables for Terraform Cloud (stored securely)
variable "db_password" {
  description = "Database password - stored in Terraform Cloud as sensitive variable"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "Third-party API key - stored in Terraform Cloud"
  type        = string
  sensitive   = true
}

# RDS instance for application data
resource "aws_db_subnet_group" "main" {
  name       = "webapp-db-subnet-group"
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = merge(local.common_tags, { Name = "webapp-db-subnet-group" })
}

resource "aws_db_instance" "webapp_db" {
  identifier     = "webapp-database"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_encrypted = true

  db_name  = "webapp"
  username = "admin"
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  skip_final_snapshot = true

  tags = merge(local.common_tags, { Name = "webapp-database" })
}

resource "aws_security_group" "db_sg" {
  name        = "webapp-db-sg"
  description = "Security group for RDS database"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  tags = merge(local.common_tags, { Name = "webapp-db-sg" })
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}