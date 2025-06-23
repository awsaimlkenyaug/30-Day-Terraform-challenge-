# AWS Provider Configuration
provider "aws" {
  alias  = "aws_provider"              # This alias is referenced in the module
  region = var.aws_region              # e.g., "us-east-1"
  profile = var.aws_profile            # Optional: for named AWS CLI profile
}

# Google Cloud Provider Configuration
provider "google" {
  alias   = "gcp_provider"
  project = var.gcp_project_id         # GCP project ID
  region  = var.gcp_region             # e.g., "us-central1"
  credentials = file(var.gcp_creds_file)  # Path to service account JSON key
}
