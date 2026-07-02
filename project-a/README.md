# Project A Infrastructure

This directory contains the multi-environment Terraform configurations for Project A.

## Directory Structure

- environments/: Contains environment-specific root modules.
  - dev/: Development environment configuration.
  - staging/: Staging environment configuration.
  - prod/: Production environment configuration.
- modules/: Contains reusable modular resource definitions.
  - networking/: Reusable networking module configuration skeleton.

## Usage

To provision a specific environment, navigate to the corresponding directory under environments/ and execute the standard Terraform workflow:

1. Initialize the workspace:
   terraform init

2. Plan the deployment:
   terraform plan

3. Apply the configuration:
   terraform apply
