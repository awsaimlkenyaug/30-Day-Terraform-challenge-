#!/bin/bash

echo "Starting AWS configuration setup..."

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_DEFAULT_REGION" ]; then
  echo "WARNING: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, or AWS_DEFAULT_REGION environment variables are not set."
  echo "Skipping 'aws configure' setup. Please set these variables on your host or manually configure AWS CLI inside the container."
else
  echo "Environment variables found. Running 'aws configure'..."

  aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile default
  aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile default
  aws configure set region "$AWS_DEFAULT_REGION" --profile default
  aws configure set output json --profile default 

  echo "AWS CLI configured successfully with default profile."
fi

echo "AWS configuration setup complete."