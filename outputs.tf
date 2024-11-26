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
  value = { for name, module in module.cloud_run_services : name => module.cname_record }
}

# Postgres secret name output
output "postgres_root_secret_name" {
  description = "The Secret Manager secret storing the root user password."
  value       = module.belay_postgres_instance.postgres_root_secret_name
}
