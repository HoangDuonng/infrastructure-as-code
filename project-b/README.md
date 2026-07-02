# Project B Infrastructure

This directory contains the Terraform configurations for Project B, representing a Virtual Private Server (VPS) infrastructure deployment on Vultr.

## Configuration Details

- main.tf: Declares the Vultr provider and provisions a virtual instance running Docker.
- variables.tf: Defines parameters such as the Vultr API key, OS ID, instance plan, and region.
- docker-compose.yml.example: Template file for running application services via Docker Compose on the provisioned host.
- nginx.conf.example: Template configuration for the Nginx web server running as a reverse proxy.

## Usage

1. Copy the variables template file:
   cp terraform.tfvars.example terraform.tfvars

2. Define the Vultr API key and parameters in the terraform.tfvars file.

3. Initialize the workspace:
   terraform init

4. Execute the deployment:
   terraform apply
