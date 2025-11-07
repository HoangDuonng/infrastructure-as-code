# Networking Module
# Reusable module for creating networking resources

# Example: VPC Module
# resource "google_compute_network" "vpc" {
#   name                    = "${var.project_name}-${var.environment}-vpc"
#   auto_create_subnetworks = false
# }
#
# resource "google_compute_subnetwork" "subnet" {
#   name          = "${var.project_name}-${var.environment}-subnet"
#   ip_cidr_range = var.subnet_cidr
#   region        = var.region
#   network       = google_compute_network.vpc.id
# }

