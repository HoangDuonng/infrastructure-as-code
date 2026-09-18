variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP Region"
  default     = "asia-southeast1"
}

variable "repo_name" {
  type        = string
  description = "The name of the Artifact Registry repository"
  default     = "todo-repo"
}

variable "external_secrets_sa_email" {
  type        = string
  description = "The email of the Service Account attached to VMs"
}

variable "ci_sa_email" {
  type        = string
  description = "The email of the CI Service Account allowed to push images"
}

variable "puller_sa_email" {
  type        = string
  description = "The email of the Service Account allowed to pull images"
}
