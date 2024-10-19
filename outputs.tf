# Output the Cloud Run service names
output "cloud_run_service_names" {
  description = "The Cloud Run service names."
  value = {
    for name, srv in google_cloud_run_service.cloud_run_service : name => srv.name
  }
}

# Output the Cloud Run service URLs
output "cloud_run_service_urls" {
  description = "The Cloud Run service URLs."
  value = {
    for name, srv in google_cloud_run_service.cloud_run_service : name => srv.status[0].url
  }
}

# Output the CNAME records for the subdomains
output "cname_records" {
  description = "The CNAME records for the subdomains."
  value = {
    for name, record in google_dns_record_set.cname_record : name => record
  }
}

