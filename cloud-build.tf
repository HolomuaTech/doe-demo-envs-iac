# Create Cloud Build Trigger for each app
resource "google_cloudbuild_trigger" "cloud_build_trigger" {
  for_each = var.app_config

  name     = "build-trigger-${each.key}"
  project  = var.project_id
  location = "global"

  github {
    owner = each.value.github_owner
    name  = each.value.github_repo
    push {
      branch = "^main$"
    }
  }

  # Set the build configuration to use the cloudbuild.yaml in the repo
  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = ["builds", "submit", "--config=cloudbuild.yaml", "."]
    }
  }
}

