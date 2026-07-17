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
