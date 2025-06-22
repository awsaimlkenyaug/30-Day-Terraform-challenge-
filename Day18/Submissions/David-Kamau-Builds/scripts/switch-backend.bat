@echo off
REM Script to switch between S3 and local backend configurations

if "%1"=="s3" (
  echo Switching to S3 backend configuration...
  copy ..\production\backend.tf.disabled ..\production\backend.tf
  echo Done. Run 'terraform init' to initialize the S3 backend.
) else if "%1"=="local" (
  echo Switching to local backend configuration...
  copy ..\production\backend.tf.simple ..\production\backend.tf
  echo Done. Run 'terraform init' to initialize the local backend.
) else (
  echo Usage: %0 [s3^|local]
  echo   s3    - Use S3 backend configuration
  echo   local - Use local backend configuration
  exit /b 1
)