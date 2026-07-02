variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The GCP Region"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "todo-vpc"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default     = "todo-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "The primary IP range of the subnet"
  default     = "10.0.0.0/20"
}

variable "pods_cidr_name" {
  type        = string
  description = "The name of the secondary IP range for GKE Pods"
  default     = "todo-pods"
}

variable "pods_cidr" {
  type        = string
  description = "The secondary IP range for GKE Pods"
  default     = "10.4.0.0/14"
}

variable "services_cidr_name" {
  type        = string
  description = "The name of the secondary IP range for GKE Services"
  default     = "todo-services"
}

variable "services_cidr" {
  type        = string
  description = "The secondary IP range for GKE Services"
  default     = "10.8.0.0/20"
}
