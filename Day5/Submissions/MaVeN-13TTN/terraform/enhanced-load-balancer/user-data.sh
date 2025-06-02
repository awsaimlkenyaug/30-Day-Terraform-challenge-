#!/bin/bash
# Enhanced Load Balancer User Data Script
# Day 5: Scaling Infrastructure with Terraform

# Update system packages
yum update -y

# Install and configure Apache HTTP Server
yum install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Install CloudWatch agent for detailed monitoring
if [ "${enable_monitoring}" = "true" ]; then
    yum install -y amazon-cloudwatch-agent
    
    # Basic CloudWatch agent configuration
    cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'EOF'
{
    "metrics": {
        "namespace": "CWAgent",
        "metrics_collected": {
            "cpu": {
                "measurement": [
                    "cpu_usage_idle",
                    "cpu_usage_iowait",
                    "cpu_usage_user",
                    "cpu_usage_system"
                ],
                "metrics_collection_interval": 60,
                "totalcpu": false
            },
            "disk": {
                "measurement": [
                    "used_percent"
                ],
                "metrics_collection_interval": 60,
                "resources": [
                    "*"
                ]
            },
            "diskio": {
                "measurement": [
                    "io_time"
                ],
                "metrics_collection_interval": 60,
                "resources": [
                    "*"
                ]
            },
            "mem": {
                "measurement": [
                    "mem_used_percent"
                ],
                "metrics_collection_interval": 60
            }
        }
    },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/var/log/httpd/access_log",
                        "log_group_name": "${cluster_name}-access-logs",
                        "log_stream_name": "{instance_id}/access_log"
                    },
                    {
                        "file_path": "/var/log/httpd/error_log",
                        "log_group_name": "${cluster_name}-error-logs",
                        "log_stream_name": "{instance_id}/error_log"
                    }
                ]
            }
        }
    }
}
EOF

    # Start CloudWatch agent
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
        -a fetch-config \
        -m ec2 \
        -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
        -s
fi

# Create a custom index.html with server information
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Day 5: Enhanced Load Balancer</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
            max-width: 600px;
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        .emoji {
            font-size: 3em;
            margin: 20px 0;
        }
        .server-info {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }
        .status {
            display: inline-block;
            background: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            margin: 10px 0;
            font-weight: bold;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin: 20px 0;
            text-align: left;
        }
        .info-item {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 8px;
        }
        .info-label {
            font-weight: bold;
            color: #FFD700;
        }
        .footer {
            margin-top: 30px;
            font-size: 0.9em;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="emoji">🚀</div>
        <h1>Day 5: Enhanced Load Balancer</h1>
        <p style="font-size: 1.2em; margin-bottom: 30px;">${server_text}</p>
        
        <div class="status">Server Online & Healthy</div>
        
        <div class="server-info">
            <h3>Server Information</h3>
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-label">Instance ID:</div>
                    <div id="instance-id">Loading...</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Availability Zone:</div>
                    <div id="availability-zone">Loading...</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Instance Type:</div>
                    <div id="instance-type">Loading...</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Server Port:</div>
                    <div>${server_port}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Cluster:</div>
                    <div>${cluster_name}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Load Balanced:</div>
                    <div>✅ Yes</div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>🏗️ <strong>30-Day Terraform Challenge</strong> | Day 5: Scaling Infrastructure</p>
            <p>⚡ Powered by AWS Elastic Load Balancer & Auto Scaling</p>
            <p>🔧 Built with Terraform Infrastructure as Code</p>
        </div>
    </div>

    <script>
        // Fetch EC2 metadata
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

        // Load instance metadata
        fetchMetadata('instance-id', 'instance-id');
        fetchMetadata('placement/availability-zone', 'availability-zone');
        fetchMetadata('instance-type', 'instance-type');

        // Add some interactive elements
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.container');
            container.addEventListener('mouseover', function() {
                this.style.transform = 'scale(1.02)';
                this.style.transition = 'transform 0.3s ease';
            });
            container.addEventListener('mouseout', function() {
                this.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>
EOF

# Create a health check endpoint
cat > /var/www/html/health << 'EOF'
{
    "status": "healthy",
    "timestamp": "$(date -Iseconds)",
    "server_port": "${server_port}",
    "cluster": "${cluster_name}",
    "version": "day5-enhanced-v1.0"
}
EOF

# Configure Apache to serve on the specified port
sed -i "s/Listen 80/Listen ${server_port}/" /etc/httpd/conf/httpd.conf

# Add security headers
cat >> /etc/httpd/conf/httpd.conf << 'EOF'

# Security Headers
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
Header always set X-XSS-Protection "1; mode=block"
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
Header always set Referrer-Policy "strict-origin-when-cross-origin"

# Enable compression
LoadModule deflate_module modules/mod_deflate.so
<Location />
    SetOutputFilter DEFLATE
    SetEnvIfNoCase Request_URI \
        \.(?:gif|jpe?g|png)$ no-gzip dont-vary
    SetEnvIfNoCase Request_URI \
        \.(?:exe|t?gz|zip|bz2|sit|rar)$ no-gzip dont-vary
</Location>
EOF

# Restart Apache to apply all configurations
systemctl restart httpd

# Create a simple monitoring script
cat > /usr/local/bin/health-monitor.sh << 'EOF'
#!/bin/bash
# Simple health monitoring script
while true; do
    if ! systemctl is-active --quiet httpd; then
        systemctl restart httpd
        logger "Apache restarted by health monitor"
    fi
    sleep 30
done
EOF

chmod +x /usr/local/bin/health-monitor.sh

# Start health monitor in background
nohup /usr/local/bin/health-monitor.sh > /var/log/health-monitor.log 2>&1 &

# Log successful completion
echo "$(date): Enhanced Load Balancer server setup completed successfully" >> /var/log/user-data.log
echo "Server Text: ${server_text}" >> /var/log/user-data.log
echo "Server Port: ${server_port}" >> /var/log/user-data.log
echo "Cluster Name: ${cluster_name}" >> /var/log/user-data.log
echo "Monitoring Enabled: ${enable_monitoring}" >> /var/log/user-data.log
