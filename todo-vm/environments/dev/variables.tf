variable "project_id" {
  description = "The GCP Project ID where resources will be managed."
  type        = string
}

variable "region" {
  description = "The default GCP Region for regional resources."
  type        = string
  default     = "asia-southeast1"
}

variable "zone" {
  description = "The default GCP Zone for instances."
  type        = string
  default     = "asia-southeast1-a"
}

variable "environment" {
  description = "The deployment environment name."
  type        = string
  default     = "dev"
}

variable "master_machine_type" {
  description = "The machine type for the Kubernetes master node"
  type        = string
  default     = "e2-medium"
}

variable "worker_machine_type" {
  description = "The machine type for the Kubernetes worker nodes"
  type        = string
  default     = "e2-medium"
}

variable "worker_count" {
  description = "The number of Kubernetes worker nodes"
  type        = number
  default     = 3
}

variable "ssh_public_key" {
  description = "The literal SSH public key content to install on the instances"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8... placeholder"
}
