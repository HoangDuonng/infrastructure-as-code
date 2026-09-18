resource "google_artifact_registry_repository" "todo_repo" {
  location      = var.region
  repository_id = var.repo_name
  description   = "Docker repository for Todo application microservices"
  format        = "DOCKER"

  cleanup_policies {
    id     = "delete-all-versions"
    action = "DELETE"
    condition {
      tag_state = "ANY"
    }
  }

  cleanup_policies {
    id     = "keep-5-most-recent"
    action = "KEEP"
    most_recent_versions {
      keep_count = 5
    }
  }
}

resource "google_artifact_registry_repository_iam_member" "reader" {
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.todo_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.external_secrets_sa_email}"
}

resource "google_artifact_registry_repository_iam_member" "ci_writer" {
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.todo_repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${var.ci_sa_email}"
}

resource "google_artifact_registry_repository_iam_member" "puller_reader" {
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.todo_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${var.puller_sa_email}"
}
