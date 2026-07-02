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
  description = "The GKE cluster zonal location."
  type        = string
  default     = "asia-southeast1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "todo-cluster"
}
