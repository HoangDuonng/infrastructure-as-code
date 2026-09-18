resource "google_service_account" "external_secrets" {
  account_id   = var.gsa_name
  display_name = "External Secrets Operator GSA"
  project      = var.project_id
}

# Service account impersonated by GitHub Actions via the existing github-pool
resource "google_service_account" "ci" {
  account_id   = var.ci_gsa_name
  display_name = "GitHub Actions CI"
  project      = var.project_id
}

resource "google_service_account_iam_member" "ci_workload_identity" {
  service_account_id = google_service_account.ci.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.github_pool_id}/attribute.repository/${var.github_repo}"
}
