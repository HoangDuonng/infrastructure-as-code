output "master_public_ip" {
  description = "The public IP of the Kubernetes master node"
  value       = module.vms.master_public_ip
}

output "master_private_ip" {
  description = "The private IP of the Kubernetes master node"
  value       = module.vms.master_private_ip
}

output "worker_public_ips" {
  description = "The public IPs of the Kubernetes worker nodes"
  value       = module.vms.worker_public_ips
}

output "worker_private_ips" {
  description = "The private IPs of the Kubernetes worker nodes"
  value       = module.vms.worker_private_ips
}

output "infra_public_ip" {
  description = "The public IP of the Kubernetes infra node"
  value       = module.vms.infra_public_ip
}

output "infra_private_ip" {
  description = "The private IP of the Kubernetes infra node"
  value       = module.vms.infra_private_ip
}

output "sql_private_ip" {
  description = "The private IP of the Cloud SQL instance (DB host for the app)"
  value       = module.sql.private_ip
}

output "sql_connection_name" {
  description = "The Cloud SQL connection name"
  value       = module.sql.connection_name
}

