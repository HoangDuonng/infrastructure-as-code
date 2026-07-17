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
