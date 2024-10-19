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

# Call the Cloud Run module for environment-specific deployments
module "cloud_run" {
  source   = "git::https://github.com/derrinc/tf-gcp-cloud-run.git"
  region   = var.region
  app_name = var.app_name
  memory   = var.memory
  cpu      = var.cpu
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
}

