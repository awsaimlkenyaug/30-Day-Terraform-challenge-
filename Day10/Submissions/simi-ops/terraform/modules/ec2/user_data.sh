#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>30-Day Terraform Challenge - ${environment}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f0f0f0; }
        .container { background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .environment { color: #007acc; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to the 30-Day Terraform Challenge!</h1>
        <h2>Environment: <span class="environment">${environment}</span></h2>
        <p>This is a web server deployed using Terraform modules.</p>
        <p>Instance details:</p>
        <ul>
            <li>Environment: ${environment}</li>
            <li>Deployed with: Terraform</li>
            <li>Module: EC2 v1.0.0</li>
        </ul>
    </div>
</body>
</html>
EOF