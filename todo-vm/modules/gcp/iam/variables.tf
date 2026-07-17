variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "gsa_name" {
  type        = string
  description = "The name of the Google Service Account for External Secrets Operator"
  default     = "external-secrets-sa"
}

variable "k8s_namespace" {
  type        = string
  description = "The Kubernetes namespace of the service account for workload identity"
  default     = "external-secrets"
}

variable "k8s_service_account" {
  type        = string
  description = "The Kubernetes service account name for workload identity"
  default     = "external-secrets"
}
