# doe-demo-envs-iac/variables.tf

variable "project_id" {
  type        = string
  description = "GCP Project ID where resources will be created."
}

variable "project_number" {
  type        = string
  description = "GCP numeric project ID"
}

variable "region" {
  type        = string
  description = "The GCP region where resources will be created."
}

variable "app_name" {
  type        = string
  description = "Name of the Cloud Run application."
}

variable "memory" {
  type        = string
  description = "Memory limit for Cloud Run service."
}

variable "cpu" {
  type        = string
  description = "CPU limit for Cloud Run service."
}

variable "image_url" {
  type        = string
  default     = "gcr.io/cloudrun/hello"
  description = "List of subdomains to create CNAME records for."
}

variable "cname_subdomains" {
  type        = list(string)
  description = "List of subdomains to create CNAME records for."
}

# New variable for the domain
variable "domain_name" {
  type        = string
  description = "The custom domain for the Cloud Run application."
}
