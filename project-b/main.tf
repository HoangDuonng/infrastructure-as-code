# Project B - Vultr Infrastructure
# Simple setup with Docker Compose and Nginx

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.0"
    }
  }
  
  # Uncomment and configure your backend
  # backend "s3" {
  #   bucket = "terraform-state-bucket"
  #   key    = "project-b/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "vultr" {
  api_key     = var.vultr_api_key
  rate_limit  = 700
  retry_limit = 3
}

# Example: Vultr VPS instance
# resource "vultr_instance" "web_server" {
#   plan   = var.instance_plan
#   region = var.region
#   os_id  = var.os_id
#   
#   label  = "web-server"
#   tags   = ["web", "docker"]
# }

