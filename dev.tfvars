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
    image_url       = "gcr.io/cloudrun/hello"
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
