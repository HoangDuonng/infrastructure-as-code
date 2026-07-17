output "master_public_ip" {
  description = "The public IP of the Kubernetes master node"
  value       = google_compute_instance.master.network_interface[0].access_config[0].nat_ip
}

output "master_private_ip" {
  description = "The private IP of the Kubernetes master node"
  value       = google_compute_instance.master.network_interface[0].network_ip
}

output "worker_public_ips" {
  description = "The public IPs of the Kubernetes worker nodes"
  value       = google_compute_instance.workers[*].network_interface[0].access_config[0].nat_ip
}

output "worker_private_ips" {
  description = "The private IPs of the Kubernetes worker nodes"
  value       = google_compute_instance.workers[*].network_interface[0].network_ip
}
