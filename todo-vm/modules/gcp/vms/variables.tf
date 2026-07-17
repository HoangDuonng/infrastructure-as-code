variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP Region"
  type        = string
}

variable "zone" {
  description = "The GCP Zone to place the VMs in"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g. dev)"
  type        = string
}

variable "network" {
  description = "The self link or ID of the VPC network"
  type        = string
}

variable "subnetwork" {
  description = "The self link or ID of the subnet"
  type        = string
}

variable "master_machine_type" {
  description = "The machine type for the Master node"
  type        = string
  default     = "e2-medium"
}

variable "worker_machine_type" {
  description = "The machine type for the Worker nodes"
  type        = string
  default     = "e2-medium"
}

variable "worker_count" {
  description = "The number of worker nodes to create"
  type        = number
  default     = 3
}

variable "os_image" {
  description = "The OS image for the VM instances"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "external_secrets_sa_email" {
  description = "The email of the Google Service Account for Secret Manager access"
  type        = string
}

variable "ssh_public_key" {
  description = "The literal SSH public key content to install on the instances"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8... placeholder"
}
