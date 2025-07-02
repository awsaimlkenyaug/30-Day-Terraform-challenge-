#!/bin/bash
yum update -y
yum install -y httpd aws-cli
systemctl start httpd
systemctl enable httpd

# Install AWS CLI and retrieve secrets
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id ${secret_name} --region $REGION --query SecretString --output text)

# Extract individual secrets (in production, use proper JSON parsing)
DB_PASSWORD=$(echo $SECRET_VALUE | jq -r '.database_password')
API_KEY=$(echo $SECRET_VALUE | jq -r '.api_key')
JWT_SECRET=$(echo $SECRET_VALUE | jq -r '.jwt_secret')

# Create application configuration (masked for security)
cat > /etc/app-config.json << EOF
{
  "database": {
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

# Secure the config file
chmod 600 /etc/app-config.json
chown root:root /etc/app-config.json

cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>30-Day Terraform Challenge - ${environment}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f0f0f0; }
        .container { background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .environment { color: #007acc; font-weight: bold; }
        .secure { color: #28a745; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the 30-Day Terraform Challenge Day 13!</h1>
        <h2>Environment: <span class="environment">${environment}</span></h2>
        <p>This is a web server with <span class="secure">secure secrets management</span> using AWS Secrets Manager.</p>
        <p>Instance details:</p>
        <ul>
            <li>Environment: ${environment}</li>
            <li>Deployed with: Terraform</li>
            <li>Secrets: Securely managed via AWS Secrets Manager</li>
            <li>Module: EC2 v1.0.0</li>
        </ul>
        <p><strong>Security Features:</strong></p>
        <ul>
            <li>✅ Secrets stored in AWS Secrets Manager</li>
            <li>✅ IAM role-based access control</li>
            <li>✅ Sensitive data masked in Terraform state</li>
            <li>✅ Runtime secret retrieval</li>
        </ul>
    </div>
</body>
</html>
EOF