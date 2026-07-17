output "external_secrets_sa_email" {
  value       = google_service_account.external_secrets.email
  description = "The email of the Google Service Account for External Secrets"
}
