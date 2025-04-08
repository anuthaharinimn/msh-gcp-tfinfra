terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.26"
    }
  }
}

provider "google" {
  project = projectrunner
  region  = "us-central1"
}

terraform {
  backend "gcs" {
    bucket = bucketreplace
    prefix = "terraform/state"
  }
}
