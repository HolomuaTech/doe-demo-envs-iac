variable "belay_postgres_cidr_subnet" {
  description = "Subnet name for Belay PostgreSQL"
  type        = string
}

variable "belay_db_instance_name" {
  description = "Cloud SQL instance name for Belay"
  type        = string
}

variable "belay_postgres_version" {
  description = "PostgreSQL version for Belay"
  type        = string
  default     = "POSTGRES_14"
}

variable "belay_instance_size" {
  description = "Machine type for the Belay PostgreSQL instance"
  type        = string
  default     = "db-f1-micro"
}

variable "belay_disk_size" {
  description = "Disk size for the Belay PostgreSQL instance"
  type        = number
  default     = 10
}

variable "belay_deletion_protection" {
  description = "Enable or disable deletion protection for Belay database instance"
  type        = bool
  default     = false
}

variable "belay_database_name" {
  description = "Application database name"
  type        = string
}

