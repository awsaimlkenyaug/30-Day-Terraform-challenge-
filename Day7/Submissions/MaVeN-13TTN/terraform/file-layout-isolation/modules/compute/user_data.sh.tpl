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
    <title>Terraform File Layout Demo - ${environment}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: rgba(255, 255, 255, 0.95);
            color: #333;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 25px;
        }
        .info-box {
            background-color: #f8f9fa;
            border-left: 6px solid #007bff;
            padding: 15px;
            margin: 15px 0;
            border-radius: 5px;
        }
        .env-dev { border-left-color: #28a745; }
        .env-staging { border-left-color: #ffc107; }
        .env-prod { border-left-color: #dc3545; }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .feature-card {
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .icon {
            font-size: 2em;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏗️ Terraform File Layout Isolation</h1>
            <h2>Day 7: State Management Challenge</h2>
            <p>Environment: <strong>${environment}</strong> | Application: <strong>${application_name}</strong></p>
        </div>
        
        <div class="info-box env-${environment}">
            <h3>🔧 Environment Information</h3>
            <p><strong>Environment:</strong> ${environment}</p>
            <p><strong>Application:</strong> ${application_name}</p>
            <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
            <p><strong>Availability Zone:</strong> <span id="az">Loading...</span></p>
            <p><strong>Instance Type:</strong> <span id="instance-type">Loading...</span></p>
            <p><strong>Public IP:</strong> <span id="public-ip">Loading...</span></p>
            <p><strong>Private IP:</strong> <span id="private-ip">Loading...</span></p>
        </div>
        
        <div class="features">
            <div class="feature-card">
                <div class="icon">🗂️</div>
                <h4>File Layout Isolation</h4>
                <p>Separate directories for each environment with dedicated state files</p>
            </div>
            <div class="feature-card">
                <div class="icon">🔧</div>
                <h4>Modular Architecture</h4>
                <p>Reusable modules for VPC, compute, and security groups</p>
            </div>
            <div class="feature-card">
                <div class="icon">🔒</div>
                <h4>State Security</h4>
                <p>Remote state storage with encryption and locking</p>
            </div>
            <div class="feature-card">
                <div class="icon">⚡</div>
                <h4>Auto Scaling</h4>
                <p>Dynamic scaling based on CPU utilization</p>
            </div>
        </div>
        
        <div class="info-box">
            <h3>📁 File Layout Structure</h3>
            <pre style="background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto;">
terraform/
├── modules/
│   ├── vpc/
│   ├── compute/
│   └── security-groups/
└── environments/
    ├── dev/
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── terraform.tfvars
    ├── staging/
    └── prod/</pre>
        </div>
        
        <div class="info-box">
            <h3>✅ Benefits of File Layout Isolation</h3>
            <ul>
                <li><strong>Complete Separation:</strong> Each environment has its own directory</li>
                <li><strong>Independent Backends:</strong> Separate state files and backends</li>
                <li><strong>Flexible Configuration:</strong> Environment-specific variables and settings</li>
                <li><strong>Reduced Risk:</strong> Impossible to accidentally affect other environments</li>
                <li><strong>Easy CI/CD:</strong> Simple deployment pipelines per environment</li>
            </ul>
        </div>
        
        <footer style="text-align: center; margin-top: 30px; color: #6c757d; font-size: 0.9em;">
            <p>🎯 30-Day Terraform Challenge - Day 7 | File Layout State Isolation</p>
            <p>Built with ❤️ by MaVeN-13TTN | Powered by AWS & Terraform</p>
        </footer>
    </div>

    <script>
        // Fetch instance metadata
        function fetchMetadata(endpoint, elementId) {
            fetch('http://169.254.169.254/latest/meta-data/' + endpoint)
                .then(response => response.text())
                .then(data => {
                    document.getElementById(elementId).textContent = data;
                })
                .catch(error => {
                    document.getElementById(elementId).textContent = 'N/A';
                });
        }

        // Load metadata when page loads
        window.onload = function() {
            fetchMetadata('instance-id', 'instance-id');
            fetchMetadata('placement/availability-zone', 'az');
            fetchMetadata('instance-type', 'instance-type');
            fetchMetadata('public-ipv4', 'public-ip');
            fetchMetadata('local-ipv4', 'private-ip');
        };
    </script>
</body>
</html>
EOF

# Set proper permissions
chown apache:apache /var/www/html/index.html
chmod 644 /var/www/html/index.html
