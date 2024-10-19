project_id     = "holomua-doe-demo"
project_number = "675849533921"
region         = "us-west1"

app_config = {
  "doe-demo-ui" = {
    app_name        = "doe-demo-ui"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "dev.ui"
    domain_name     = "dev.ui.holomuatech.online"
    image_url       = "gcr.io/cloudrun/hello"
  },
  "doe-demo-api" = {
    app_name        = "doe-demo-api"
    memory          = "128Mi"
    cpu             = "0.08"
    cname_subdomain = "dev.api"
    domain_name     = "dev.api.holomuatech.online"
    image_url       = "gcr.io/cloudrun/hello"
  }
}
