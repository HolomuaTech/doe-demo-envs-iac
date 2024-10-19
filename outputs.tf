# Output the Cloud Run service name
output "cloud_run_service_name" {
  description = "The Cloud Run service name."
  value       = google_cloud_run_service.cloud_run_service.name
}

# Output the Cloud Run service URL
output "cloud_run_service_url" {
  description = "The Cloud Run service URL."
  value       = google_cloud_run_service.cloud_run_service.status[0].url
}

# Output the CNAME record for the subdomain
output "cname_record" {
  description = "The CNAME record for the subdomain."
  value       = google_dns_record_set.cname_record
}

