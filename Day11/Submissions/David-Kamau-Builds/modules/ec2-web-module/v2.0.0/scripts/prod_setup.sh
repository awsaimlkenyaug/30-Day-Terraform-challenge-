#!/bin/bash
# Production environment setup script
yum update -y
yum install -y amazon-cloudwatch-agent
systemctl enable amazon-cloudwatch-agent
systemctl start amazon-cloudwatch-agent

# Security updates
yum install -y yum-cron
sed -i 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
systemctl enable yum-cron

echo "PRODUCTION ENVIRONMENT" > /etc/motd