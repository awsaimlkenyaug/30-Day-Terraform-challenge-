provider "aws" {
  region = "us-east-1"
}

resource "aws_secretsmanager_secret" "db_secret" {
  name        = "db_password"
  description = "My DB password"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "admin"
    password = "SuperSecureP@ssw0rd"
  })
}

resource "aws_instance" "example" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Fetching secrets"
              yum install -y aws-cli jq
              secret=$(aws secretsmanager get-secret-value --secret-id db_password --region us-east-1 | jq -r '.SecretString')
              echo "$secret" > /tmp/db_creds.json
              EOF

  tags = {
    Name = "SecretsManagerInstance"
  }
}
