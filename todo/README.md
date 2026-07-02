# Todo Application Infrastructure

This directory contains the Terraform configuration files required to provision the infrastructure for the Todo application on Google Cloud Platform (GCP).

## Architecture Overview

The configuration provisions the following resources:
- A custom Virtual Private Cloud (VPC) network and subnetwork with Private Google Access enabled.
- A Google Kubernetes Engine (GKE) zonal cluster configured with Workload Identity and secondary IP ranges for pod and service routing.
- Google Service Accounts (GSA) bound to Kubernetes Service Accounts (KSA) for authorization.
- Google Secret Manager secrets to store application credentials.
- An Artifact Registry Docker repository to store container images.

## Project Structure

- main.tf: Root configuration file invoking the GCP modules.
- variables.tf: Root input variables schema.
- terraform.tfvars.example: Configuration values template.
- modules/: Subdirectories containing modularized resource definitions.

## Usage

1. Authenticate with Google Cloud:
   gcloud auth application-default login

2. Copy the template and define the required variables:
   cp terraform.tfvars.example terraform.tfvars

3. Initialize the workspace:
   terraform init

4. Review the execution plan:
   terraform plan

5. Apply the configuration:
   terraform apply
