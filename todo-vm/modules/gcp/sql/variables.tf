variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP Region for the Cloud SQL instance"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, staging, prod)"
  default     = "dev"
}

variable "network_self_link" {
  type        = string
  description = "The self link of the VPC network for private IP peering"
}

variable "mysql_secret_id" {
  type        = string
  description = "Full resource ID of the Secret Manager secret that will hold the Cloud SQL root password (created by the secrets module)"
}

variable "db_tier" {
  type        = string
  description = "The Cloud SQL machine tier (db-f1-micro is cheapest for learning)"
  default     = "db-f1-micro"
}

variable "db_disk_size_gb" {
  type        = number
  description = "Initial disk size in GB (autoresize is enabled)"
  default     = 10
}

variable "enable_backups" {
  type        = bool
  description = "Enable automated backups + binary logging (PITR) for backup learning"
  default     = true
}
