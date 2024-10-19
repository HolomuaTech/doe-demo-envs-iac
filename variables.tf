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

variable "app_name" {
  type        = string
  description = "Name of the Cloud Run application."
}

variable "memory" {
  type        = string
  description = "Memory limit for the Cloud Run service."
}

variable "cpu" {
  type        = string
  description = "CPU limit for the Cloud Run service."
}

variable "image_url" {
  type        = string
  default     = "gcr.io/cloudrun/hello"
  description = "The Docker image URL for the Cloud Run service."
}

variable "domain_name" {
  type        = string
  description = "The custom domain for the Cloud Run application."
}

variable "cname_subdomain" {
  type        = string
  description = "The subdomain to create a CNAME record for."
}
