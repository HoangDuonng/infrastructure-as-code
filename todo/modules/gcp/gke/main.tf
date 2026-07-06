resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone

  network    = var.network
  subnetwork = var.subnetwork

  # We must delete the default node pool to follow GKE best practices
  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_cidr_name
    services_secondary_range_name = var.services_cidr_name
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  network_policy {
    enabled  = true
    provider = "PROVIDER_UNSPECIFIED"
  }

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "default-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_type    = var.disk_type
    disk_size_gb = var.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }
}
