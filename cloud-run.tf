# Fetch existing DNS managed zone
data "google_dns_managed_zone" "public_zone" {
  name    = "holomuatech-online"
  project = var.project_id
}

# Fetch Artifact Registry repository details
data "google_artifact_registry_repository" "artifact_registry" {
  repository_id = var.artifact_registry_repo_name
  location      = var.artifact_registry_repo_location
  project       = var.project_id
}

# Loop through each app in the app_config to create Cloud Run services using the module
module "cloud_run_services" {
  source = "git::https://github.com/HolomuaTech/tf-gcp-cloud-run.git?ref=refactor-split"

  for_each = var.app_config

  app_name        = each.key
  image           = each.value.image_url
  region          = var.region
  memory          = each.value.memory
  cpu             = each.value.cpu
  dns_zone_name   = data.google_dns_managed_zone.public_zone.name
  dns_name        = chomp(data.google_dns_managed_zone.public_zone.dns_name)
  cname_subdomain = each.value.cname_subdomain
  domain_name     = each.value.domain_name
  project_number  = var.project_number

  # Removed the service_account_name argument
  # service_account_name = try(each.value.service_account_name, null)

  # Pass environment variables
  public_env_vars = try(each.value.public_env_vars, {})  # Default to empty map if null
  secret_env_vars = try(each.value.private_env_vars, {}) # Map secrets to `secret_env_vars`

  # Pass Artifact Registry details to the module
  artifact_registry_repo_name     = data.google_artifact_registry_repository.artifact_registry.repository_id
  artifact_registry_repo_location = data.google_artifact_registry_repository.artifact_registry.location
  project_id                      = var.project_id

  # Pass the grant_cloudsql_access flag
  grant_cloudsql_access = try(each.value.grant_cloudsql_access, false)
}

