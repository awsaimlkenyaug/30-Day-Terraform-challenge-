module "secrets" {
  source = "../modules/secrets-module"
  
  name_prefix = var.name_prefix
  environment = var.environment
  
  secret_values = {
    db_username = var.db_username
    db_password = var.db_password
    api_key     = var.api_key
    jwt_secret  = var.jwt_secret
  }
}

resource "aws_db_instance" "example" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "${var.name_prefix}${var.environment}db"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  
  tags = {
    Name        = "${var.name_prefix}-${var.environment}-db"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}