# Production Environment - Backend Configuration
# This file defines where Terraform stores its state

terraform {
  backend "gcs" {
    bucket = "terraform-state-project-a-prod"  # Update with your GCS bucket name
    prefix = "prod"                             # State file prefix
  }
}

# Alternative backends:
# - backend "s3" { ... }     # For AWS S3
# - backend "azurerm" { ... } # For Azure Storage
# - backend "remote" { ... }  # For Terraform Cloud

