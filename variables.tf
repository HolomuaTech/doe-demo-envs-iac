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

