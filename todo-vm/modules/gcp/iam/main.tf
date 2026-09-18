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

# Least-privilege puller used only by kubelets (via imagePullSecret) to read GAR
resource "google_service_account" "gar_puller" {
  account_id   = var.puller_gsa_name
  display_name = "GAR image puller for self-managed nodes"
  project      = var.project_id
}

# Key material is consumed once into a k8s imagePullSecret; rotate by tainting
resource "google_service_account_key" "gar_puller" {
  service_account_id = google_service_account.gar_puller.name
}

resource "google_service_account_iam_member" "ci_workload_identity" {
  service_account_id = google_service_account.ci.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.github_pool_id}/attribute.repository/${var.github_repo}"
}
