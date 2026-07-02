variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP Region"
}

variable "zone" {
  type        = string
  description = "The GKE Zonal location"
}

variable "cluster_name" {
  type        = string
  description = "The GKE Cluster Name"
}

variable "network" {
  type        = string
  description = "The VPC network self link or name"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork self link or name"
}

variable "pods_cidr_name" {
  type        = string
  description = "The secondary IP range name for pods"
}

variable "services_cidr_name" {
  type        = string
  description = "The secondary IP range name for services"
}

variable "machine_type" {
  type        = string
  description = "The machine type for the GKE nodes"
  default     = "e2-medium"
}

variable "node_count" {
  type        = number
  description = "The number of nodes in the node pool"
  default     = 3
}
