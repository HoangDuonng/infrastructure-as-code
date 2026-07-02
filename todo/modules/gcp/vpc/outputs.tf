output "network_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC network"
}

output "network_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The self link of the VPC network"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "The name of the subnet"
}

output "subnet_self_link" {
  value       = google_compute_subnetwork.subnet.self_link
  description = "The self link of the subnet"
}

output "pods_cidr_name" {
  value       = var.pods_cidr_name
  description = "The name of the secondary range for pods"
}

output "services_cidr_name" {
  value       = var.services_cidr_name
  description = "The name of the secondary range for services"
}
