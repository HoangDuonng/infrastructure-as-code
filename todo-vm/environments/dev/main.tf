module "vpc" {
  source      = "../../modules/gcp/vpc"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = "todo-vpc-${var.environment}"
  subnet_name = "todo-subnet-${var.environment}"
}

module "iam" {
  source     = "../../modules/gcp/iam"
  project_id = var.project_id
  gsa_name   = "external-secrets-sa-${var.environment}"
}

module "vms" {
  source                    = "../../modules/gcp/vms"
  project_id                = var.project_id
  region                    = var.region
  zone                      = var.zone
  environment               = var.environment
  network                   = module.vpc.network_self_link
  subnetwork                = module.vpc.subnet_self_link
  master_machine_type       = var.master_machine_type
  worker_machine_type       = var.worker_machine_type
  worker_count              = var.worker_count
  ssh_public_key            = var.ssh_public_key
  external_secrets_sa_email = module.iam.external_secrets_sa_email
}

module "artifact_registry" {
  source                    = "../../modules/gcp/artifact-registry"
  project_id                = var.project_id
  region                    = var.region
  repo_name                 = "todo-repo-${var.environment}"
  external_secrets_sa_email = module.iam.external_secrets_sa_email
}

module "secrets" {
  source                    = "../../modules/gcp/secrets"
  project_id                = var.project_id
  external_secrets_sa_email = module.iam.external_secrets_sa_email
  environment               = var.environment
}
