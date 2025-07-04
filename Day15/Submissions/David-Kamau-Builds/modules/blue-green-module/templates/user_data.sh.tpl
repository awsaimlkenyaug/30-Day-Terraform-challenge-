#!/bin/bash
yum update -y
yum install -y httpd jq aws-cli

systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << EOF
<html>
<body>
  <h1>This is ${environment} environment</h1>
  <p>Version: ${version}</p>
</body>
</html>
EOF

if [ -n "${secret_name}" ]; then
  if ! command -v aws &> /dev/null; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
  fi
  
  SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id ${secret_name} --region ${region} --query SecretString --output text)
  
  DB_USERNAME=$(echo $SECRET_VALUE | jq -r '.db_username')
  DB_PASSWORD=$(echo $SECRET_VALUE | jq -r '.db_password')
  API_KEY=$(echo $SECRET_VALUE | jq -r '.api_key')
  JWT_SECRET=$(echo $SECRET_VALUE | jq -r '.jwt_secret')
  
  cat > /etc/app-config.json << EOF
{
  "database": {
    "username": "$DB_USERNAME",
    "password": "$DB_PASSWORD"
  },
  "api": {
    "key": "$API_KEY"
  },
  "jwt": {
    "secret": "$JWT_SECRET"
  }
}
EOF

  chmod 600 /etc/app-config.json
  chown root:root /etc/app-config.json
  
  cat >> /var/www/html/index.html << EOF
  <p>Application configured with secrets from AWS Secrets Manager</p>
EOF
fi