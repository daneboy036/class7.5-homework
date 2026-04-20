# STAGE 2: VPC FOUNDATION
# Goal:
# - Enable required APIs
# - Create custom VPC
#
# Verify:
# - Compute API enabled
# - VPC named "main" exists
#
# Screenshot required:
# - API page
# - VPC Networks page

# google_project_service allows you to manage a single api service for your google cloud projecgt
# these are used to enable/disable gcp apis and services within a prjoect
# it will enable the service for your project
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false # don't disable the service when you destroy the resource
}

resource "google_project_service" "container" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "main" {
  name                            = "main"
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460 # size of bytes of the largest IP packet allowed on the network
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
