#!/bin/bash
# Development environment setup script
yum update -y
yum install -y git vim

echo "DEVELOPMENT ENVIRONMENT" > /etc/motd