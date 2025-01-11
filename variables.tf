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

variable "env" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "app_config" {
  description = "Configuration for multiple applications."
  type = map(object({
    app_name              = string
    memory                = string
    cpu                   = string
    cname_subdomain       = string
    domain_name           = string
    github_owner          = string
    github_repo           = string
    image_url             = string
    service_account_name  = optional(string, null)
    public_env_vars       = optional(map(string), {}) # Key-value pairs for public environment variables
    private_env_vars      = optional(map(string), {}) # Key-value pairs for private environment variables
    grant_cloudsql_access = optional(bool, false)     # Flat to grant access to the postgres db instance
  }))
}

# DNS configuration for Cloud Run
variable "dns_zone_name" {
  description = "Name of the GCP DNS zone resource for creating the CNAME record (e.g., example-com-zone)"
  type        = string
}

variable "dns_name" {
  description = "DNS domain name (e.g., example.com)"
  type        = string
}

variable "artifact_registry_repo_name" {
  type        = string
  description = "The ID of the Artifact Registry repository used by Cloud Run."
}

variable "artifact_registry_repo_location" {
  type        = string
  description = "The location of the Artifact Registry repository (region)."
}

variable "public_env_vars" {
  description = "Public environment variables as key-value pairs."
  type        = map(string)
  default     = {} # Default to empty map
}

variable "private_env_vars" {
  description = "Private environment variables with key-value pairs of environment variable names and secret names."
  type        = map(string)
  default     = {} # Default to empty map
}

# For the github repo
variable "github_token" {
  description = "GitHub Personal Access Token for authentication"
  type        = string
  sensitive   = true
}

variable "helm_chart_repo" {
  description = "Configuration for the Helm chart repository"
  type = object({
    name         = string
    organization = string
    description  = string
    visibility   = string
    auto_init    = bool
  })
}
