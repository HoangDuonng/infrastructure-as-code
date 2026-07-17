resource "google_secret_manager_secret" "mysql_root_password" {
  secret_id = "mysql-root-password-${var.environment}"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "mysql_accessor" {
  secret_id = google_secret_manager_secret.mysql_root_password.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.external_secrets_sa_email}"
}

resource "google_secret_manager_secret" "jwt_secret" {
  secret_id = "jwt-secret-${var.environment}"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_iam_member" "jwt_accessor" {
  secret_id = google_secret_manager_secret.jwt_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.external_secrets_sa_email}"
}
