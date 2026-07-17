resource "google_service_account" "external_secrets" {
  account_id   = var.gsa_name
  display_name = "External Secrets Operator GSA"
  project      = var.project_id
}
