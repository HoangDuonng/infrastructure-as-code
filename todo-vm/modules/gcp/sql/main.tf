# Enable APIs required for Cloud SQL with private IP
resource "google_project_service" "sqladmin" {
  project            = var.project_id
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "servicenetworking" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

# Reserved range for VPC peering with Google services (must not overlap
# 10.0.0.0/20 subnet, 10.4.0.0/14 pods, 10.8.0.0/20 services)
resource "google_compute_global_address" "private_peering" {
  name          = "todo-sql-peering-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_self_link
  project       = var.project_id
}

resource "google_service_networking_connection" "private_vpc" {
  network                 = var.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_peering.name]

  depends_on = [google_project_service.servicenetworking]
}

resource "random_password" "root" {
  length  = 20
  special = false
}

resource "google_sql_database_instance" "mysql" {
  name                = "todo-mysql-${var.environment}"
  project             = var.project_id
  region              = var.region
  database_version    = "MYSQL_8_0"
  deletion_protection = false

  depends_on = [google_service_networking_connection.private_vpc]

  settings {
    tier = var.db_tier

    disk_size       = var.db_disk_size_gb
    disk_autoresize = true

    # Private IP only: reachable from GCE VMs over the VPC, no public exposure
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
    }

    # Automated backups + binary log => point-in-time recovery (for backup learning)
    backup_configuration {
      enabled            = var.enable_backups
      start_time         = "03:00"
      binary_log_enabled = true

      backup_retention_settings {
        retained_backups = 7
      }
    }

    maintenance_window {
      day  = 7
      hour = 4
    }
  }
}

# Same databases the in-cluster mysql.yaml init script creates
resource "google_sql_database" "dbs" {
  for_each = toset(["todo-auth", "todo-task", "todo-user"])
  name     = each.value
  instance = google_sql_database_instance.mysql.name
  project  = var.project_id
}

resource "google_sql_user" "root" {
  name     = "root"
  host     = "%"
  instance = google_sql_database_instance.mysql.name
  project  = var.project_id
  password = random_password.root.result
}

# Publish the root password to the existing secret (created by the secrets
# module) so ESO picks it up automatically, same as before
resource "google_secret_manager_secret_version" "mysql_root" {
  secret      = var.mysql_secret_id
  secret_data = random_password.root.result
}
