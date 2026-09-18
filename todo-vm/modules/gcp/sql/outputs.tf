output "instance_name" {
  value       = google_sql_database_instance.mysql.name
  description = "The Cloud SQL instance name"
}

output "private_ip" {
  value       = google_sql_database_instance.mysql.private_ip_address
  description = "The private IP of the Cloud SQL instance (use as DB host from the VMs)"
}

output "connection_name" {
  value       = google_sql_database_instance.mysql.connection_name
  description = "The Cloud SQL connection name (project:region:instance)"
}

output "root_password" {
  value       = random_password.root.result
  sensitive   = true
  description = "The Cloud SQL root password (also stored in Secret Manager)"
}
