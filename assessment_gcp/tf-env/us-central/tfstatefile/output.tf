output "bucket" {
    value = google_storage_bucket.default.url
}

output "project_name" {
  value = "projectrunner"
}

output "state_bucket_name" {
  value = google_storage_bucket.default.name
}