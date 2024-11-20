resource "google_compute_network" "vpc" {
  name                    = "${var.env}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloud_run_subnet" {
  name          = "${var.env}-cloud-run-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.cloud_run_cidr_range
}

resource "google_compute_subnetwork" "postgres_subnet" {
  name          = "${var.env}-postgres-subnet"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.postgres_cidr_range
}

resource "google_vpc_access_connector" "serverless_connector" {
  name         = "${var.env}-vpc-connector"
  region       = var.region
  network      = google_compute_network.vpc.id
  ip_cidr_range = var.vpc_connector_cidr
}

