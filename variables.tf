# doe-demo-envs-iac/variables.tf

variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be created."
}

variable "project_number" {
  type        = string
  description = "GCP numeric project ID."
}

variable "region" {
  type        = string
  description = "The GCP region where resources will be created."
}

variable "app_config" {
  description = "Configuration for the multiple applications"
  type = map(object({
    app_name        = string
    memory          = string
    cpu             = string
    cname_subdomain = string
    domain_name     = string
    github_owner    = string
    github_repo     = string
    image_url       = string
  }))
}

### Network configuration
variable "env" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "cloud_run_cidr_range" {
  description = "CIDR range for the Cloud Run subnet"
  type        = string
  default     = "10.0.1.0/24" # Default for dev
}

variable "postgres_cidr_range" {
  description = "CIDR range for the PostgreSQL subnet"
  type        = string
  default     = "10.0.2.0/24" # Default for dev
}

variable "vpc_connector_cidr" {
  description = "CIDR range for the VPC Connector"
  type        = string
  default     = "10.8.0.0/28" # Default for dev
}

