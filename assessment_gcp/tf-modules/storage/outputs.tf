output "bucket_name" {
  value = google_storage_bucket.tech_bucket.name
}

output "archive_name" {
  value = google_storage_bucket_object.archive.name
}
