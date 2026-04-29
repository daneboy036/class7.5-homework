terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.29.0"
    }
  }
}

provider "google" {
  project = "bmc-7dot5"
  region  = "us-central1"

  default_labels = {
    managed_by = "terraform"
    owner      = "dc"
  }
}
