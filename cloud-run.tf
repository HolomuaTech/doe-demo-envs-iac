# Fetch existing DNS managed zone
data "google_dns_managed_zone" "public_zone" {
  name    = "holomuatech-online"
  project = var.project_id
}

# Loop through each app in the app_config to create Cloud Run services using the module
module "cloud_run_services" {
  source = "git::https://github.com/HolomuaTech/tf-gcp-cloud-run.git"

  for_each = var.app_config

  app_name        = each.key
  image           = each.value.image_url
  region          = var.region
  memory          = each.value.memory
  cpu             = each.value.cpu

  # Pass DNS information to the module
  dns_zone_name   = data.google_dns_managed_zone.public_zone.name  # Pass the managed zone name
  dns_name        = chomp(data.google_dns_managed_zone.public_zone.dns_name)  # Pass the domain name
  cname_subdomain = each.value.cname_subdomain

  # Domain mapping information
  domain_name     = each.value.domain_name
  project_number  = var.project_number

  # Optionally pass secrets to specific apps (adjust as needed)
  secret_name     = try(each.value.secret_name, null)
  secret_key      = try(each.value.secret_key, null)
  env_variable_name = try(each.value.env_variable_name, null)
}

