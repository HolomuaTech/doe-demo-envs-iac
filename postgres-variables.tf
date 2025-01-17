# PostgreSQL-specific Variables

variable "db_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL version for the database"
  type        = string
  default     = "POSTGRES_14"
}

variable "instance_size" {
  description = "Machine type for the PostgreSQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_size" {
  description = "Disk size in GB for the PostgreSQL instance"
  type        = number
  default     = 10
}

variable "deletion_protection" {
  description = "Enable or disable deletion protection for the PostgreSQL instance"
  type        = bool
  default     = false
}

variable "database_name" {
  description = "Name of the PostgreSQL database to be created"
  type        = string
}

variable "cname_subdomain" {
  description = "Subdomain for the PostgreSQL database DNS entry"
  type        = string
}

variable "authorized_networks" {
  description = "List of authorized networks for accessing the PostgreSQL instance"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

