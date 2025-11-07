# Simple setup with Docker Compose and Nginx

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.27.1"
    }
  }
  
}

provider "vultr" {
  api_key     = var.vultr_api_key
  rate_limit  = 700
  retry_limit = 3
}

# Vultr VPS instance
resource "vultr_instance" "web_server" {
  plan   = var.instance_plan
  region = var.region
  os_id  = var.os_id
  
  label  = "${var.environment}-web-server"
  tags   = ["web", "docker", "nginx", var.environment]
  
  hostname = "${var.environment}-server"
  enable_ipv6 = false
  
  # Firewall group (optional - uncomment nếu có firewall)
  # firewall_group_id = vultr_firewall_group.web.id
  
  # User data script để setup Docker và Docker Compose
  user_data = file("${path.module}/scripts/user-data.sh")
}

# SSH Key (optional - khuyến nghị dùng)
# resource "vultr_ssh_key" "main" {
#   name    = "${var.environment}-ssh-key"
#   ssh_key = file("~/.ssh/id_rsa.pub")
# }

# Firewall group (optional)
# resource "vultr_firewall_group" "web" {
#   description = "Firewall for web server"
# }
#
# resource "vultr_firewall_rule" "http" {
#   firewall_group_id = vultr_firewall_group.web.id
#   protocol          = "tcp"
#   ip_type           = "v4"
#   subnet            = "0.0.0.0"
#   subnet_size       = 0
#   port              = "80"
# }
#
# resource "vultr_firewall_rule" "https" {
#   firewall_group_id = vultr_firewall_group.web.id
#   protocol          = "tcp"
#   ip_type           = "v4"
#   subnet            = "0.0.0.0"
#   subnet_size       = 0
#   port              = "443"
# }
#
# resource "vultr_firewall_rule" "ssh" {
#   firewall_group_id = vultr_firewall_group.web.id
#   protocol          = "tcp"
#   ip_type           = "v4"
#   subnet            = "0.0.0.0"
#   subnet_size       = 0
#   port              = "22"
# }

