output "endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Master endpoint URL"
}

output "ca_certificate" {
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  description = "GKE CA certificate data"
}
