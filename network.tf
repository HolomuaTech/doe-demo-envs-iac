### Create the VPC - one per environment
module "network" {
  source = "git::https://github.com/HolomuaTech/tf-gcp-network.git"

  network_name = "${var.env}-vpc"
  subnet_configs = [
    {
      name       = "${var.env}-cloud-run-subnet"
      region     = var.region
      cidr_range = var.cloud_run_cidr_range
    },
    {
      name       = "${var.env}-postgres-subnet"
      region     = var.region
      cidr_range = var.postgres_cidr_range
    }
  ]

  enable_vpc_connector         = true
  vpc_connector_name           = "${var.env}-vpc-connector"
  vpc_connector_region         = var.region
  vpc_connector_cidr           = var.vpc_connector_cidr
  vpc_connector_min_throughput = var.vpc_connector_min_throughput
  vpc_connector_max_throughput = var.vpc_connector_max_throughput
  vpc_connector_machine_type   = var.vpc_connector_machine_type

  cloud_run_subnet_cidr = var.cloud_run_cidr_range
  postgres_subnet_cidr  = var.postgres_cidr_range
}

