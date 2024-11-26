module "belay_postgres_instance" {
  source              = "git::https://github.com/HolomuaTech/tf-gcp-postgresql.git"
  project_id          = var.project_id
  region              = var.region
  vpc_name            = "${var.env}-vpc"
  subnet_name         = var.belay_postgres_cidr_subnet
  instance_name       = var.belay_db_instance_name
  postgres_version    = var.belay_postgres_version
  instance_size       = var.belay_instance_size
  disk_size           = var.belay_disk_size
  deletion_protection = var.belay_deletion_protection
  database_name       = var.belay_database_name
}
