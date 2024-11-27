# doe-demo-envs-iac/outputs.tf

# Output the Cloud Run service names from the module
output "cloud_run_service_names" {
  description = "The Cloud Run service names from the module."
  value       = { for name, module in module.cloud_run_services : name => module.cloud_run_url }
}

# Output the Cloud Run service URLs from the module
output "cloud_run_service_urls" {
  description = "The Cloud Run service URLs from the module."
  value       = { for name, module in module.cloud_run_services : name => module.cloud_run_url }
}

# Output the CNAME records for the subdomains
output "cname_records" {
  description = "The CNAME records for the subdomains."
  value       = { for name, module in module.cloud_run_services : name => module.cname_record }
}

# Postgres root secret name output
output "postgres_root_secret_name" {
  description = "The Secret Manager secret storing the root user password."
  value       = module.postgres_instance.postgres_root_secret_name
}

# Postgres database connection secret name output
output "postgres_db_secret_name" {
  description = "The Secret Manager secret storing the PostgreSQL connection details."
  value       = module.postgres_instance.postgres_secret_name
}

output "postgres_connection_name" {
  description = "The connection name of the PostgreSQL instance."
  value       = module.postgres_instance.postgres_connection_name
}

output "postgres_database_name" {
  description = "The name of the PostgreSQL database."
  value       = module.postgres_instance.postgres_database_name
}

output "postgres_secret_name" {
  description = "The Secret Manager secret storing PostgreSQL connection details."
  value       = module.postgres_instance.postgres_secret_name
}
