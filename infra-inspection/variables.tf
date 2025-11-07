# Project B - Variables

variable "vultr_api_key" {
  description = "Vultr API Key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Vultr Region"
  type        = string
  default     = "sgp" # Singapore
}

variable "instance_plan" {
  description = "Vultr Instance Plan"
  type        = string
  default     = "vc2-1c-1gb" # 1 vCPU, 1GB RAM
}

variable "os_id" {
  description = "Operating System ID"
  type        = number
  default     = 387 # Ubuntu 22.04
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
