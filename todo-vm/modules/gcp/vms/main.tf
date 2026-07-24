resource "google_compute_instance" "master" {
  name         = "todo-master-${var.environment}"
  machine_type = var.master_machine_type
  zone         = var.zone
  project      = var.project_id

  tags = ["k8s-node", "k8s-master"]

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Dynamic public IP
    }
  }

  service_account {
    email  = var.external_secrets_sa_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

resource "google_compute_instance" "workers" {
  count        = var.worker_count
  name         = "todo-worker-${count.index + 1}-${var.environment}"
  machine_type = var.worker_machine_type
  zone         = var.zone
  project      = var.project_id

  tags = ["k8s-node", "k8s-worker"]

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Dynamic public IP
    }
  }

  service_account {
    email  = var.external_secrets_sa_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# Firewall rule: Allow internal communication in VPC (needed for K8s pod network overlay & Calico IPIP)
resource "google_compute_firewall" "allow_internal" {
  name    = "todo-allow-internal-${var.environment}"
  network = var.network
  project = var.project_id

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/16", "192.168.0.0/16", "10.244.0.0/16"]
}

# Firewall rule: Allow SSH from outside
resource "google_compute_firewall" "allow_ssh" {
  name    = "todo-allow-ssh-${var.environment}"
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Firewall rule: Allow K8s API server access
resource "google_compute_firewall" "allow_k8s_api" {
  name    = "todo-allow-k8s-api-${var.environment}"
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Firewall rule: Allow Web Traffic (HTTP, HTTPS for Rancher & Nginx Ingress)
resource "google_compute_firewall" "allow_web" {
  name    = "todo-allow-web-${var.environment}"
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Firewall rule: Allow Kubernetes NodePort services (for manual exposes)
resource "google_compute_firewall" "allow_nodeports" {
  name    = "todo-allow-nodeports-${var.environment}"
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}
