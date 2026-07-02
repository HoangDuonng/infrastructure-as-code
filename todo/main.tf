module "gke" {
  source       = "./modules/gcp/gke"
  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
}

module "iam" {
  source     = "./modules/gcp/iam"
  project_id = var.project_id
}

module "artifact_registry" {
  source     = "./modules/gcp/artifact-registry"
  project_id = var.project_id
  region     = var.region
}

module "secrets" {
  source                    = "./modules/gcp/secrets"
  project_id                = var.project_id
  external_secrets_sa_email = module.iam.external_secrets_sa_email
}
