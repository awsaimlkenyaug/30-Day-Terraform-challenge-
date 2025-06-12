# Secrets module for East Coast region (us-east-1)
module "east_secrets" {
  source = "../modules/secrets-module"
  
  name_prefix = "dkb-east"
  environment = var.environment
  
  secret_values = {
    db_username = var.db_username
    db_password = var.db_password
    api_key     = var.api_key
    jwt_secret  = var.jwt_secret
    region      = "us-east-1"
    app_env     = "production-east"
  }
  
  providers = {
    aws = aws.east
  }
}

# Secrets module for West Coast region (us-west-2)
module "west_secrets" {
  source = "../modules/secrets-module"
  
  name_prefix = "dkb-west"
  environment = var.environment
  
  secret_values = {
    db_username = var.db_username
    db_password = var.db_password
    api_key     = var.api_key
    jwt_secret  = var.jwt_secret
    region      = "us-west-2"
    app_env     = "production-west"
  }
  
  providers = {
    aws = aws.west
  }
}

# Database in East Coast region (us-east-1)
resource "aws_db_instance" "east" {
  provider             = aws.east
  identifier           = "dkb-${var.environment}-east-db"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "dkbeast${var.environment}"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  storage_encrypted    = true
  
  tags = {
    Name        = "dkb-${var.environment}-db-east"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-east-1"
    Project     = "MultiRegionDeployment"
  }
}

# Database in West Coast region (us-west-2)
resource "aws_db_instance" "west" {
  provider             = aws.west
  identifier           = "dkb-${var.environment}-west-db"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "dkbwest${var.environment}"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  storage_encrypted    = true
  
  tags = {
    Name        = "dkb-${var.environment}-db-west"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Region      = "us-west-2"
    Project     = "MultiRegionDeployment"
  }
}