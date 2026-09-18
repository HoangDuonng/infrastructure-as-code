output "external_secrets_sa_email" {
  value       = google_service_account.external_secrets.email
  description = "The email of the Google Service Account for External Secrets"
}

output "ci_sa_email" {
  value       = google_service_account.ci.email
  description = "The email of the Google Service Account for GitHub Actions CI"
}

output "puller_sa_email" {
  value       = google_service_account.gar_puller.email
  description = "The email of the Service Account used by kubelets to pull GAR images"
}

output "puller_sa_key" {
  value       = google_service_account_key.gar_puller.private_key
  sensitive   = true
  description = "Base64 private key of the puller SA (feed once into k8s imagePullSecret)"
}
