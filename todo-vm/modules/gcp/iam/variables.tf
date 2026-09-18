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

variable "ci_gsa_name" {
  type        = string
  description = "The name of the Google Service Account for GitHub Actions CI"
  default     = "github-ci"
}

variable "github_pool_id" {
  type        = string
  description = "Full resource name of the existing GitHub workload identity pool"
  default     = "projects/197818608744/locations/global/workloadIdentityPools/github-pool"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository allowed to impersonate the CI service account"
  default     = "HoangDuonng/todo-list"
}
