#!/bin/bash

# Script to switch between S3 and local backend configurations

MODE=$1

if [ "$MODE" == "s3" ]; then
  echo "Switching to S3 backend configuration..."
  cp ../production/backend.tf.disabled ../production/backend.tf
  echo "Done. Run 'terraform init' to initialize the S3 backend."
elif [ "$MODE" == "local" ]; then
  echo "Switching to local backend configuration..."
  cp ../production/backend.tf.simple ../production/backend.tf
  echo "Done. Run 'terraform init' to initialize the local backend."
else
  echo "Usage: $0 [s3|local]"
  echo "  s3    - Use S3 backend configuration"
  echo "  local - Use local backend configuration"
  exit 1
fi