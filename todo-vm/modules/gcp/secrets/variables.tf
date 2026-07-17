variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "external_secrets_sa_email" {
  type        = string
  description = "The email of the Google Service Account for External Secrets"
}

variable "environment" {
  type        = string
  description = "The environment name (e.g. dev, staging, prod)"
  default     = "dev"
}
