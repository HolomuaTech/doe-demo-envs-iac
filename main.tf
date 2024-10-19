# Define the provider
terraform {
  backend "gcs" {
    bucket = "terraform-state-envs-bucket"
    prefix = "envs"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Fetch existing DNS managed zone
data "google_dns_managed_zone" "public_zone" {
  name = "holomuatech-online"
}

# Loop through each app in the app_config
resource "google_cloud_run_service" "cloud_run_service" {
  for_each = var.app_config

  name     = each.key
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = each.value.image_url
        resources {
          limits = {
            memory = each.value.memory
            cpu    = each.value.cpu
          }
        }
      }
    }
  }
}

# Create DNS record for each app
resource "google_dns_record_set" "cname_record" {
  for_each = var.app_config

  managed_zone = data.google_dns_managed_zone.public_zone.name
  name         = "${each.value.cname_subdomain}.${data.google_dns_managed_zone.public_zone.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["ghs.googlehosted.com."]
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

  depends_on = [google_cloud_run_service.cloud_run_service]
}

