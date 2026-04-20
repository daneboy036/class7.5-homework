terraform {
  backend "gcs" {
    bucket = "bmc-sier1tf"
    prefix = "terraform/state/hw_week5"
  }
}
