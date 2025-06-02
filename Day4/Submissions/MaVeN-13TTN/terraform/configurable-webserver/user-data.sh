#!/bin/bash
# Day 4 - Configurable Web Server User Data Script
# Template file for dynamic web server configuration

# Log all actions
exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "Starting configurable web server setup..."
echo "Timestamp: $(date)"

# Update system
echo "Updating system packages..."
yum update -y

# Install Apache HTTP Server
echo "Installing Apache HTTP Server..."
yum install -y httpd

# Start and enable Apache
echo "Starting Apache service..."
systemctl start httpd
systemctl enable httpd

# Install additional tools
echo "Installing additional tools..."
yum install -y htop curl wget

# Configure Apache for custom port if needed
if [ "${server_port}" != "80" ]; then
    echo "Configuring Apache for port ${server_port}..."
    echo "Listen ${server_port}" >> /etc/httpd/conf/httpd.conf
    sed -i "s/Listen 80/Listen ${server_port}/" /etc/httpd/conf/httpd.conf
fi

# Create custom HTML content
echo "Creating custom web content..."
cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Day 4 - Configurable Web Server</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
        }
        .container { 
            max-width: 1000px; 
            margin: 0 auto; 
            background: rgba(255,255,255,0.1); 
            padding: 30px; 
            border-radius: 15px; 
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }
        h1 { 
            color: #ffffff; 
            text-align: center; 
            font-size: 2.5em;
            margin-bottom: 30px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .terraform-logo { 
            text-align: center; 
            font-size: 3em; 
            margin-bottom: 20px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .info-card { 
            background: rgba(255,255,255,0.15); 
            padding: 20px; 
            border-radius: 10px; 
            border: 1px solid rgba(255,255,255,0.2);
        }
        .info-card h3 {
            margin-top: 0;
            color: #f0f8ff;
            border-bottom: 2px solid rgba(255,255,255,0.3);
            padding-bottom: 10px;
        }
        .info-card ul {
            list-style: none;
            padding: 0;
        }
        .info-card li {
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .info-card li:last-child {
            border-bottom: none;
        }
        .highlight { 
            color: #90EE90; 
            font-weight: bold; 
        }
        .variable-badge {
            background: rgba(144, 238, 144, 0.2);
            padding: 4px 8px;
            border-radius: 4px;
            border: 1px solid rgba(144, 238, 144, 0.5);
            display: inline-block;
            margin: 2px;
        }
        .status {
            text-align: center;
            font-size: 1.2em;
            margin: 20px 0;
            padding: 15px;
            background: rgba(0,255,0,0.2);
            border-radius: 8px;
            border: 1px solid rgba(0,255,0,0.3);
        }
        .custom-content {
            background: rgba(255,255,255,0.1);
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            border-left: 4px solid #90EE90;
        }
    </style>
    <script>
        function updateTime() {
            document.getElementById('current-time').textContent = new Date().toLocaleString();
        }
        setInterval(updateTime, 1000);
        window.onload = updateTime;
    </script>
</head>
<body>
    <div class="container">
        <div class="terraform-logo">🚀 🏗️ ⚙️</div>
        <h1>Configurable Web Server - Day 4</h1>
        
        <div class="status">
            ✅ <span class="highlight">Server Successfully Deployed!</span> ✅<br>
            <small>Using Terraform Variables for Configuration</small>
        </div>

        <div class="info-grid">
            <div class="info-card">
                <h3>🏷️ Deployment Information</h3>
                <ul>
                    <li><strong>Challenge:</strong> 30-Day Terraform Challenge</li>
                    <li><strong>Day:</strong> 4 - Advanced Terraform Features</li>
                    <li><strong>Server Type:</strong> Configurable Web Server</li>
                    <li><strong>Deployed by:</strong> ${owner}</li>
                    <li><strong>Environment:</strong> <span class="variable-badge">${environment}</span></li>
                    <li><strong>Server Name:</strong> <span class="variable-badge">${server_name}</span></li>
                    <li><strong>Deploy Time:</strong> $(date)</li>
                    <li><strong>Current Time:</strong> <span id="current-time"></span></li>
                </ul>
            </div>

            <div class="info-card">
                <h3>🖥️ Server Configuration</h3>
                <ul>
                    <li><strong>Hostname:</strong> $(hostname)</li>
                    <li><strong>Private IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</li>
                    <li><strong>Public IP:</strong> $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)</li>
                    <li><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</li>
                    <li><strong>Instance Type:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-type)</li>
                    <li><strong>AZ:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</li>
                </ul>
            </div>

            <div class="info-card">
                <h3>⚙️ Variable Configuration</h3>
                <ul>
                    <li><strong>Server Port:</strong> <span class="variable-badge">${server_port}</span></li>
                    <li><strong>Environment:</strong> <span class="variable-badge">${environment}</span></li>
                    <li><strong>Owner:</strong> <span class="variable-badge">${owner}</span></li>
                    <li><strong>Server Name:</strong> <span class="variable-badge">${server_name}</span></li>
                    %{ if enable_ssl ~}
                    <li><strong>SSL:</strong> <span class="variable-badge highlight">Enabled</span></li>
                    %{ else ~}
                    <li><strong>SSL:</strong> <span class="variable-badge">Disabled</span></li>
                    %{ endif ~}
                </ul>
            </div>

            <div class="info-card">
                <h3>🔧 Key Learning Points</h3>
                <ul>
                    <li>✅ Terraform Variables (input)</li>
                    <li>✅ Terraform Outputs</li>
                    <li>✅ Data Sources</li>
                    <li>✅ Dynamic Blocks</li>
                    <li>✅ Conditional Resources</li>
                    <li>✅ Template Files</li>
                    <li>✅ Resource Dependencies</li>
                    <li>✅ Variable Validation</li>
                </ul>
            </div>
        </div>

        %{ if custom_html != "" ~}
        <div class="custom-content">
            <h3>📝 Custom Content</h3>
            <p>${custom_html}</p>
        </div>
        %{ endif ~}

        <div class="info-card">
            <h3>🔗 Useful Commands</h3>
            <ul>
                <li><strong>Check Apache Status:</strong> <code>sudo systemctl status httpd</code></li>
                <li><strong>View Logs:</strong> <code>sudo tail -f /var/log/httpd/access_log</code></li>
                <li><strong>User Data Log:</strong> <code>sudo tail -f /var/log/user-data.log</code></li>
                <li><strong>Server Info:</strong> <code>curl http://localhost:${server_port}</code></li>
            </ul>
        </div>
    </div>
</body>
</html>
HTML

# Restart Apache to apply configuration changes
echo "Restarting Apache service..."
systemctl restart httpd

# Create a simple health check endpoint
cat <<EOF > /var/www/html/health
OK
EOF

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure firewall (if running)
if systemctl is-active --quiet firewalld; then
    echo "Configuring firewall..."
    firewall-cmd --permanent --add-port=${server_port}/tcp
    firewall-cmd --reload
fi

# Final status check
echo "Checking Apache service status..."
systemctl status httpd

echo "Configurable web server setup complete!"
echo "Server accessible on port ${server_port}"
echo "Setup completed at: $(date)"
