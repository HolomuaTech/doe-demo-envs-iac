project_id     = "holomua-doe-demo"
project_number = "675849533921"
region         = "us-west1"
env            = "dev"

# Cloud run configurations. Each microservice needs its own Cloud Run instance
app_config = {
  "doe-demo-ui" = {
    app_name        = "doe-demo-ui"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "dev.ui"
    domain_name     = "dev.ui.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "doe-demo-ui"
    # image_url       = "gcr.io/cloudrun/hello"
    image_url = "us-west1-docker.pkg.dev/holomua-doe-demo/doe-demo-container-registry/doe-demo-ui"
  },
  "doe-demo-api" = {
    app_name        = "doe-demo-api"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "dev.api"
    domain_name     = "dev.api.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "doe-demo-api"
    image_url       = "gcr.io/cloudrun/hello"
  },
  "belay-ui" = {
    app_name        = "belay-ui"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "belay.dev"
    domain_name     = "belay.dev.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "belay-ui"
    image_url       = "gcr.io/cloudrun/hello"
  },
  "belay-api" = {
    app_name        = "belay-api"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "belay-api.dev"
    domain_name     = "belay-api.dev.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "belay-api"
    image_url       = "gcr.io/cloudrun/hello"
    secret_name     = "belay-db-postgres-root-password"
  }
}

# Network configuration
cloud_run_cidr_range         = "10.0.1.0/24"
postgres_cidr_range          = "10.0.2.0/24"
vpc_connector_cidr           = "10.8.0.0/28"
vpc_connector_min_throughput = 200
vpc_connector_max_throughput = 300

# VPC Access Connector machine type
vpc_connector_machine_type = "e2-micro"

# PostgreSQL database instance configuration for belay
belay_database_name        = "belay-db"
belay_db_instance_name     = "belay-db"
belay_postgres_version     = "POSTGRES_14"
belay_instance_size        = "db-f1-micro"
belay_disk_size            = 10
belay_deletion_protection  = false
belay_postgres_cidr_subnet = "dev-postgres-subnet"

