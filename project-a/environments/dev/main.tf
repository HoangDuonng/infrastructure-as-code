# Project A - Development Environment
# This is a ROOT MODULE - actual Terraform project

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Example: Call reusable modules
# module "networking" {
#   source = "../../modules/networking"
#   
#   project_name = var.project_name
#   environment  = "dev"
#   region       = var.region
#   subnet_cidr  = var.subnet_cidr
# }
#
# module "compute" {
#   source = "../../modules/compute"
#   
#   project_name = var.project_name
#   environment  = "dev"
#   region       = var.region
#   vpc_id       = module.networking.vpc_id
# }

