#!/bin/bash

# User data script for Clustered Web Server
# This script sets up an Apache web server with dynamic content

# Update the system
yum update -y

# Install Apache web server
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Get instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
INSTANCE_TYPE=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)
LOCAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
AMI_ID=$(curl -s http://169.254.169.254/latest/meta-data/ami-id)

# Create the web page content
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${application_name}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 900px;
            width: 90%;
            margin: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .header h1 {
            color: #667eea;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
            font-size: 1.2rem;
        }
        
        .badge {
            display: inline-block;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            margin: 5px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .info-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            border-left: 5px solid #667eea;
        }
        
        .info-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.3rem;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #555;
        }
        
        .info-value {
            color: #333;
            font-family: 'Monaco', 'Courier New', monospace;
            background: #e9ecef;
            padding: 2px 8px;
            border-radius: 5px;
        }
        
        .cluster-info {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-top: 30px;
            text-align: center;
        }
        
        .cluster-info h2 {
            margin-bottom: 15px;
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        
        .feature {
            background: rgba(255,255,255,0.1);
            padding: 15px;
            border-radius: 10px;
            text-align: center;
        }
        
        .timestamp {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 0.9rem;
        }
        
        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            background: #28a745;
            border-radius: 50%;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        .refresh-btn {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 20px;
            transition: transform 0.2s;
        }
        
        .refresh-btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>${application_name}</h1>
            <p>Highly Available Clustered Web Application</p>
            <div style="margin-top: 15px;">
                <span class="badge">Environment: ${environment}</span>
                <span class="badge">Version: ${application_version}</span>
                <span class="badge">Project: ${project_name}</span>
            </div>
        </div>

        <div class="cluster-info">
            <h2><span class="status-indicator"></span>Cluster Status: Operational</h2>
            <p>This instance is part of a highly available cluster with load balancing and auto-scaling capabilities.</p>
            
            <div class="features">
                <div class="feature">
                    <h4>Auto Scaling</h4>
                    <p>Dynamic instance management</p>
                </div>
                <div class="feature">
                    <h4>Load Balancing</h4>
                    <p>Traffic distribution</p>
                </div>
                <div class="feature">
                    <h4>Health Checks</h4>
                    <p>Automatic recovery</p>
                </div>
                <div class="feature">
                    <h4>Multi-AZ</h4>
                    <p>High availability</p>
                </div>
            </div>
        </div>

        <div class="info-grid">
            <div class="info-card">
                <h3>🖥️ Instance Information</h3>
                <div class="info-item">
                    <span class="info-label">Instance ID:</span>
                    <span class="info-value">$INSTANCE_ID</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Instance Type:</span>
                    <span class="info-value">$INSTANCE_TYPE</span>
                </div>
                <div class="info-item">
                    <span class="info-label">AMI ID:</span>
                    <span class="info-value">$AMI_ID</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Availability Zone:</span>
                    <span class="info-value">$AVAILABILITY_ZONE</span>
                </div>
            </div>

            <div class="info-card">
                <h3>🌐 Network Information</h3>
                <div class="info-item">
                    <span class="info-label">Private IP:</span>
                    <span class="info-value">$LOCAL_IP</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Public IP:</span>
                    <span class="info-value">$PUBLIC_IP</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Server Port:</span>
                    <span class="info-value">${server_port}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Protocol:</span>
                    <span class="info-value">HTTP</span>
                </div>
            </div>

            <div class="info-card">
                <h3>⚙️ Configuration</h3>
                <div class="info-item">
                    <span class="info-label">Environment:</span>
                    <span class="info-value">${environment}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Project:</span>
                    <span class="info-value">${project_name}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Application:</span>
                    <span class="info-value">${application_name}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Version:</span>
                    <span class="info-value">${application_version}</span>
                </div>
            </div>

            <div class="info-card">
                <h3>🚀 Deployment Info</h3>
                <div class="info-item">
                    <span class="info-label">Managed By:</span>
                    <span class="info-value">Terraform</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Challenge:</span>
                    <span class="info-value">30-Day-Terraform</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Day:</span>
                    <span class="info-value">4</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Task:</span>
                    <span class="info-value">Clustered Web Server</span>
                </div>
            </div>
        </div>

        <div class="timestamp">
            <p>Page generated at: <span id="timestamp"></span></p>
            <button class="refresh-btn" onclick="location.reload()">🔄 Refresh Instance Info</button>
        </div>
    </div>

    <script>
        // Display current timestamp
        document.getElementById('timestamp').textContent = new Date().toLocaleString();
        
        // Auto-refresh every 30 seconds
        setTimeout(function() {
            location.reload();
        }, 30000);
    </script>
</body>
</html>
EOF

# Create a health check endpoint
cat > /var/www/html/health.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Health Check</title>
</head>
<body>
    <h1>Health Check: OK</h1>
    <p>Instance ID: $INSTANCE_ID</p>
    <p>Status: Healthy</p>
    <p>Timestamp: $(date)</p>
</body>
</html>
EOF

# Create a simple API endpoint for load balancer testing
mkdir -p /var/www/html/api

cat > /var/www/html/api/status.json << EOF
{
    "status": "healthy",
    "instance_id": "$INSTANCE_ID",
    "instance_type": "$INSTANCE_TYPE",
    "availability_zone": "$AVAILABILITY_ZONE",
    "local_ip": "$LOCAL_IP",
    "public_ip": "$PUBLIC_IP",
    "environment": "${environment}",
    "project": "${project_name}",
    "application": "${application_name}",
    "version": "${application_version}",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure Apache to listen on the specified port
sed -i "s/Listen 80/Listen ${server_port}/" /etc/httpd/conf/httpd.conf

# Add custom Apache configuration
cat > /etc/httpd/conf.d/custom.conf << EOF
# Custom configuration for clustered web server
ServerTokens Prod
ServerSignature Off

# Enable mod_status for health checks
<Location "/server-status">
    SetHandler server-status
    Require local
</Location>

# Custom headers for load balancer identification
Header always set X-Instance-ID "$INSTANCE_ID"
Header always set X-Availability-Zone "$AVAILABILITY_ZONE"
Header always set X-Environment "${environment}"
EOF

# Install and configure CloudWatch agent for monitoring (optional)
if command -v amazon-cloudwatch-agent-ctl >/dev/null 2>&1; then
    echo "CloudWatch agent already installed"
else
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
    rpm -U ./amazon-cloudwatch-agent.rpm
fi

# Restart Apache to apply all configurations
systemctl restart httpd

# Enable automatic startup
systemctl enable httpd

# Log deployment completion
echo "$(date): Clustered web server deployment completed" >> /var/log/user-data.log
echo "Instance ID: $INSTANCE_ID" >> /var/log/user-data.log
echo "Environment: ${environment}" >> /var/log/user-data.log
echo "Server Port: ${server_port}" >> /var/log/user-data.log
