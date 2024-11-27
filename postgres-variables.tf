# doe-demo-envs-iac/postgres-variables.tf

# PostgreSQL-specific Variables
variable "postgres_cidr_range" {
  description = "CIDR range for the PostgreSQL subnet"
  type        = string
  default     = "10.0.2.0/24" # Default for dev
}

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
