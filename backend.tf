terraform {
  backend "gcs" {
    bucket = "terraform-state-envs-bucket" # Your GCS bucket name
    prefix = "envs"                        # Path within the bucket to store the state
  }
}
