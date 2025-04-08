resource "google_project_service" "cloud_resource_manager" {
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "storage_api" {
  service = "storage.googleapis.com"
  disable_on_destroy = false
  depends_on = [google_project_service.cloud_resource_manager]
}

resource "google_storage_bucket" "tech_bucket" {
  depends_on    = [google_project_service.storage_api]
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
  
}

resource "google_storage_bucket_object" "archive" {
  name   = var.archive_name
  bucket = google_storage_bucket.tech_bucket.name
  source = var.functioncode
}