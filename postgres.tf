module "postgres_instance" {
  source              = "git::https://github.com/HolomuaTech/tf-gcp-postgresql.git"
  project_id          = var.project_id
  region              = var.region
  vpc_name            = "${var.env}-vpc"
  subnet_name         = var.postgres_cidr_subnet # Correctly pass the subnet name
  instance_name       = var.db_instance_name
  postgres_version    = var.postgres_version
  instance_size       = var.instance_size
  disk_size           = var.disk_size
  deletion_protection = var.deletion_protection
  database_name       = var.database_name
}
