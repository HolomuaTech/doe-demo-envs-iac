# Fetch existing DNS managed zone
data "google_dns_managed_zone" "public_zone" {
  name    = "holomuatech-online"
  project = var.project_id
}

# Loop through each app in the app_config to create Cloud Run services
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

  # The "hello" container should only be set if cloud run is being initialized
  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image
    ]
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

  # Add lifecycle block to ignore more changes
  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].namespace,
      # metadata[0].effective_annotations,
      spec[0].force_override
    ]
  }

  depends_on = [google_cloud_run_service.cloud_run_service]
}
