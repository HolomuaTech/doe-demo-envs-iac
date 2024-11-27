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
  description = "Configuration for multiple applications"
  type = map(object({
    app_name          = string
    memory            = string
    cpu               = string
    cname_subdomain   = string
    domain_name       = string
    github_owner      = string
    github_repo       = string
    image_url         = string
    secret_name       = optional(string, null) # Optional for apps that don't use secrets
    secret_key        = optional(string, "latest")
    env_variable_name = optional(string, null) # Optional environment variable
  }))
}

# Network Configuration
variable "env" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "cloud_run_cidr_range" {
  description = "Name of the GCP subnet resource for the cloud run network"
  type        = string
}

variable "postgres_cidr_subnet" {
  description = "Name of the GCP subnet resource for the postgres db network"
  type        = string
}

variable "vpc_connector_cidr" {
  description = "CIDR range for the VPC Connector"
  type        = string
  default     = "10.8.0.0/28" # Default for dev
}

variable "vpc_connector_min_throughput" {
  description = "Minimum throughput for VPC connector (in Mbps)"
  type        = number
  default     = 200
}

variable "vpc_connector_max_throughput" {
  description = "Maximum throughput for VPC connector (in Mbps)"
  type        = number
  default     = 200
}

variable "vpc_connector_machine_type" {
  description = "VPC Connector machine type"
  type        = string
  default     = "e2-micro"
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
