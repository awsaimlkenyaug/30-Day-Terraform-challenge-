# Remote State Management

This directory contains Terraform configuration for setting up remote state management using AWS S3 and DynamoDB.

## Features

- S3 bucket for storing Terraform state files
- Versioning enabled for state history
- Server-side encryption for security
- Public access blocking for enhanced security
- DynamoDB table for state locking

## Usage

1. Apply this configuration first:
   ```
   cd remote-state
   terraform init
   terraform apply
   ```

2. Once the S3 bucket and DynamoDB table are created, you can use the backend configuration in other modules.

## Security Features

- Bucket versioning
- Server-side encryption
- Public access blocking
- State locking with DynamoDB