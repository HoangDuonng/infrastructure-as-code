output "repository_id" {
  value       = google_artifact_registry_repository.todo_repo.id
  description = "The ID of the Artifact Registry repository"
}
