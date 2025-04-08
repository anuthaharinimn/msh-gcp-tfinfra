terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.26"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "google" {
  project = "projectrunner"
  region  = "us-central1"
}

resource "random_id" "default" {
  byte_length = 2
}

# terraform bucket creation with versioning enabled
resource "google_storage_bucket" "default" {
  name     = "tf-statefile-msh-${random_id.default.hex}"
  location = "US"
  force_destroy = true
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

