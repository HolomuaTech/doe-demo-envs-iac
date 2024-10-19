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

# Define locals for dynamic resource names
locals {
  dns_record_name    = "cname_record_${replace(var.cname_subdomain, ".", "_")}"
  domain_mapping_name = "domain_mapping_${replace(var.cname_subdomain, ".", "_")}"
  service_name        = "cloud_run_service_${replace(var.cname_subdomain, ".", "_")}"
}

# ------------------------------
# DNS CNAME Record for the subdomain
# ------------------------------
# Fetch existing DNS managed zone
data "google_dns_managed_zone" "public_zone" {
  name = "holomuatech-online"
}

# Add CNAME Record for the subdomain
resource "google_dns_record_set" "cname_record" {
  managed_zone = data.google_dns_managed_zone.public_zone.name
  name         = "${var.cname_subdomain}.${data.google_dns_managed_zone.public_zone.dns_name}" # Single subdomain
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["ghs.googlehosted.com."]
}

# ------------------------------
# Cloud Run Domain Mapping
# ------------------------------
resource "google_cloud_run_domain_mapping" "domain_mapping" {
  name     = var.domain_name # Use environment-specific domain
  location = var.region

  metadata {
    namespace = var.project_number
    annotations = {
      "run.googleapis.com/override-headers" = "X-Forwarded-Proto=https"
    }
  }

  spec {
    route_name       = var.app_name # Use the app_name variable directly
    certificate_mode = "AUTOMATIC"
  }
}

# ------------------------------
# Cloud Run Service
# ------------------------------
resource "google_cloud_run_service" "cloud_run_service" {
  name     = var.app_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image_url # Use the image URL from your tfvars or other source
        resources {
          limits = {
            memory = var.memory
            cpu    = var.cpu
          }
        }
      }
    }
  }

  # Only add the container image if this is the initial setup.
  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image
    ]
  }
}

