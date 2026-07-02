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
