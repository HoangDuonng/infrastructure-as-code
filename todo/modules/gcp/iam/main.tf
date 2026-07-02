resource "google_service_account" "external_secrets" {
  account_id   = var.gsa_name
  display_name = "External Secrets Operator GSA"
}

resource "google_service_account_iam_member" "workload_identity" {
  service_account_id = google_service_account.external_secrets.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.k8s_namespace}/${var.k8s_service_account}]"
}
