project_id     = "holomua-doe-demo"
project_number = "675849533921"
region         = "us-west1"
env            = "dev"

# Top-level domain name for DNS
dns_zone_name = "holomuatech-online" # GCP Cloud DNS service name
dns_name      = "holomuatech.online" # Base domain name

# Artifact Registry configuration
artifact_registry_repo_name     = "doe-demo-container-registry"
artifact_registry_repo_location = "us-west1"

# Cloud Run configurations. Each microservice needs its own Cloud Run instance
app_config = {
  "doe-demo-ui" = {
    app_name        = "doe-demo-ui"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "dev.ui"
    domain_name     = "dev.ui.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "doe-demo-ui"
    image_url       = "gcr.io/cloudrun/hello"
    # No database access needed
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
    # No database access needed
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
    # No database access needed
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
    public_env_vars = {
      PGHOST     = "belay-dev-db.holomuatech.online"
      PGPORT     = "5432"
      PGDATABASE = "belay-dev"
      PGUSER     = "postgres"
    }
    private_env_vars = {
      PGPASSWORD = "belay-dev-postgres-root-password"
    }
    grant_cloudsql_access = true # Enable Cloud SQL access for belay-api
  }
}

# PostgreSQL database instance configuration
database_name       = "belay-dev"
db_instance_name    = "belay-dev"
postgres_version    = "POSTGRES_14"
instance_size       = "db-f1-micro"
disk_size           = 10
deletion_protection = false
cname_subdomain     = "belay-dev"

