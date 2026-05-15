# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  name                            = "week9-vpc"
  routing_mode                    = "GLOBAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false # this means delete teh default internet route 0.0.0.0/0 with this false vms can reach the internet

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
