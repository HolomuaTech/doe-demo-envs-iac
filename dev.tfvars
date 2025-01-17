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
    cname_subdomain = "helloworld.demo"
    domain_name     = "helloworld.demo.holomuatech.online"
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
    memory          = "256Mi"
    cpu             = "0.25"
    cname_subdomain = "belay.dev"
    domain_name     = "belay.dev.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "belay-ui"
    image_url       = "gcr.io/cloudrun/hello"
    public_env_vars = {
      NEXT_PUBLIC_GITHUB_CLIENT_ID = "Ov23liczS04mMDejrthN"
      NEXT_PUBLIC_APP_URL          = "https://belay.dev.holomuatech.online"
      NEXT_PUBLIC_API_URL          = "https://belay-api.dev.holomuatech.online"
      NEXTAUTH_URL                 = "https://belay.dev.holomuatech.online"
    }
    private_env_vars = {
      GITHUB_CLIENT_SECRET = "belay-ui-env-GITHUB_CLIENT_SECRET"
      NEXTAUTH_SECRET      = "belay-ui-env-NEXTAUTH_SECRET"
    }
  },
  "belay-api" = {
    app_name        = "belay-api"
    memory          = "512Mi"
    cpu             = "0.5"
    cname_subdomain = "belay-api.dev"
    domain_name     = "belay-api.dev.holomuatech.online"
    github_owner    = "derrinc"
    github_repo     = "belay-api"
    image_url       = "gcr.io/cloudrun/hello"
    public_env_vars = {
      DatabaseSettings__Host     = "belay-dev-db.holomuatech.online"
      DatabaseSettings__Database = "belay"
      DatabaseSettings__Username = "postgres"
      ASPNETCORE_URLS            = "http://*:8080"
    }
    private_env_vars = {
      DatabaseSettings__Password = "belay-dev-postgres-root-password"
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
authorized_networks = [
  {
    name  = "everywhere"
    value = "0.0.0.0/0"
  }
]

# Github repo for application helm chart
helm_chart_repo = {
  name         = "helm-charts-doe-demo"
  organization = "HolomuaTech"
  description  = "Repository for Helm charts for the Doe Demo project."
  visibility   = "private"
  auto_init    = true
}

