module "vpc" {
  source      = "../../modules/gcp/vpc"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = "todo-vpc-${var.environment}"
  subnet_name = "todo-subnet-${var.environment}"
}

module "gke" {
  source             = "../../modules/gcp/gke"
  project_id         = var.project_id
  region             = var.region
  zone               = var.zone
  cluster_name       = "todo-cluster-${var.environment}"
  network            = module.vpc.network_self_link
  subnetwork         = module.vpc.subnet_self_link
  pods_cidr_name     = module.vpc.pods_cidr_name
  services_cidr_name = module.vpc.services_cidr_name
  machine_type       = var.gke_machine_type
  node_count         = var.gke_node_count
}

module "iam" {
  source     = "../../modules/gcp/iam"
  project_id = var.project_id
  gsa_name   = "external-secrets-sa-${var.environment}"
}

module "artifact_registry" {
  source     = "../../modules/gcp/artifact-registry"
  project_id = var.project_id
  region     = var.region
  repo_name  = "todo-repo-${var.environment}"
}

module "secrets" {
  source                    = "../../modules/gcp/secrets"
  project_id                = var.project_id
  external_secrets_sa_email = module.iam.external_secrets_sa_email
  environment               = var.environment
}
