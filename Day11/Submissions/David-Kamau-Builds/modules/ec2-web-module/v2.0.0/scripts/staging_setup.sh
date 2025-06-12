#!/bin/bash
# Staging environment setup script
yum update -y
yum install -y htop

echo "STAGING ENVIRONMENT" > /etc/motd