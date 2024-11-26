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

  # Optionally pass secrets to specific apps (adjust as needed)
  secret_name     = try(each.value.secret_name, null)
  secret_key      = try(each.value.secret_key, null)
  env_variable_name = try(each.value.env_variable_name, null)
}

# Create Cloud Run domain mapping for each app
resource "google_cloud_run_domain_mapping" "domain_mapping" {
  for_each = var.app_config

  name     = each.value.domain_name
  location = var.region

  metadata {
    namespace = var.project_number
    annotations = {
      "run.googleapis.com/override-headers" = "X-Forwarded-Proto=https"
    }
  }

  spec {
    route_name       = each.key
    certificate_mode = "AUTOMATIC"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].namespace,
      spec[0].force_override
    ]
  }

  depends_on = [module.cloud_run_services]
}
