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
