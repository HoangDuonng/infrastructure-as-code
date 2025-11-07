# Project B - Outputs

output "instance_ip" {
  description = "VPS Instance IP Address"
  value       = vultr_instance.web_server.main_ip
}

output "instance_id" {
  description = "VPS Instance ID"
  value       = vultr_instance.web_server.id
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    ip_address = vultr_instance.web_server.main_ip
    region     = var.region
    plan       = var.instance_plan
    environment = var.environment
    status     = "Deploy docker-compose.yml and nginx.conf to the server"
  }
}

