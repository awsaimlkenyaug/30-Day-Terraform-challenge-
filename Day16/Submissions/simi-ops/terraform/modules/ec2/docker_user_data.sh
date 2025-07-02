#!/bin/bash
yum update -y

# Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group
usermod -a -G docker ec2-user

# Pull and run your Docker image
docker pull simimwanza/simi-ops

# Run the container on port 80
docker run -d -p 80:80 --name simi-ops-app --restart unless-stopped simimwanza/simi-ops

# Create a simple health check endpoint if the container doesn't have one
cat > /tmp/health_check.sh << 'EOF'
#!/bin/bash
if docker ps | grep -q simi-ops-app; then
    echo "Container is running"
    exit 0
else
    echo "Container is not running, restarting..."
    docker start simi-ops-app || docker run -d -p 80:80 --name simi-ops-app --restart unless-stopped simimwanza/simi-ops
    exit 1
fi
EOF

chmod +x /tmp/health_check.sh

# Set up a cron job to check container health every 5 minutes
echo "*/5 * * * * /tmp/health_check.sh" | crontab -

# Create a fallback HTML page in case Docker fails
mkdir -p /var/www/html
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Simi-Ops Application - ${environment}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f0f0f0; }
        .container { background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .environment { color: #007acc; font-weight: bold; }
        .docker { color: #0db7ed; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Simi-Ops Application</h1>
        <h2>Environment: <span class="environment">${environment}</span></h2>
        <p>This application is running in a <span class="docker">Docker</span> container.</p>
        <p>Docker Image: <code>simimwanza/simi-ops</code></p>
        <p>Instance details:</p>
        <ul>
            <li>Environment: ${environment}</li>
            <li>Deployed with: Terraform + Docker</li>
            <li>Container: simi-ops-app</li>
            <li>Port: 80</li>
        </ul>
        <p><em>If you're seeing this page, the Docker container may be starting up...</em></p>
    </div>
</body>
</html>
EOF

# Install and start Apache as fallback (in case Docker fails)
yum install -y httpd
systemctl enable httpd

# Wait a moment for Docker to start the container
sleep 10

# Check if Docker container is running, if not start Apache as fallback
if ! docker ps | grep -q simi-ops-app; then
    echo "Docker container failed to start, using Apache fallback"
    systemctl start httpd
fi