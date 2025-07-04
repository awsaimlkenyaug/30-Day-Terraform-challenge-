# Secrets module for us-east-1 region
module "east_secrets" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
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

# Secrets module for us-west-2 region
module "west_secrets" {
  count  = var.deployment_mode == "deploy" ? 1 : 0
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