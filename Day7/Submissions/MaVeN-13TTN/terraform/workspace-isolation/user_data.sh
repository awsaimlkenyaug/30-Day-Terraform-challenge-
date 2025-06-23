#!/bin/bash
yum update -y
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page with environment info
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Terraform Workspace Isolation Demo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .header {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
        }
        .info-box {
            background-color: #e7f3ff;
            border-left: 6px solid #2196F3;
            padding: 10px;
            margin: 10px 0;
        }
        .env-${environment} {
            border-left-color: #ff9800;
        }
        .env-staging {
            border-left-color: #2196F3;
        }
        .env-prod {
            border-left-color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Terraform Workspace Demo</h1>
            <h2>Day 7: State Isolation Challenge</h2>
        </div>
        
        <div class="info-box env-${environment}">
            <h3>Environment Information</h3>
            <p><strong>Environment:</strong> ${environment}</p>
            <p><strong>Workspace:</strong> ${workspace}</p>
            <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
            <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
            <p><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</p>
            <p><strong>Public IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)</p>
            <p><strong>Private IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</p>
        </div>
        
        <div class="info-box">
            <h3>About This Demo</h3>
            <p>This server was deployed using Terraform workspaces for state isolation.</p>
            <p>Each environment (dev, staging, prod) uses different configurations:</p>
            <ul>
                <li><strong>Dev:</strong> t2.micro instances, 1-2 capacity, 10.0.0.0/16 VPC</li>
                <li><strong>Staging:</strong> t3.small instances, 2-4 capacity, 10.1.0.0/16 VPC</li>
                <li><strong>Prod:</strong> t3.medium instances, 3-10 capacity, 10.2.0.0/16 VPC</li>
            </ul>
        </div>
        
        <div class="info-box">
            <h3>State Isolation Benefits</h3>
            <ul>
                <li>✅ Isolated infrastructure state per environment</li>
                <li>✅ Shared configuration with environment-specific values</li>
                <li>✅ Easy environment switching with terraform workspace commands</li>
                <li>✅ Reduced risk of accidental environment impact</li>
            </ul>
        </div>
        
        <footer style="text-align: center; margin-top: 30px; color: #666;">
            <p>🎯 30-Day Terraform Challenge - Day 7 | State Isolation via Workspaces</p>
            <p>Built with ❤️ by MaVeN-13TTN</p>
        </footer>
    </div>
</body>
</html>
EOF

# Set proper permissions
chown apache:apache /var/www/html/index.html
chmod 644 /var/www/html/index.html
