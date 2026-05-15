# template -- templates are global
resource "google_compute_instance_template" "template" {
  name_prefix  = "web-server-"
  machine_type = "e2-small"

  disk {
    auto_delete  = true
    boot         = true
    source_image = "centos-cloud/centos-stream-10"
  }

  # create new template before destroying the old
  lifecycle {
    create_before_destroy = true
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  metadata_startup_script = file("${path.module}/../assets/startup-for-rhel.sh")

  tags = ["web-server"]
}

# healthcheck
resource "google_compute_health_check" "healthcheck" {
  name                = "web-server-healthcheck"
  check_interval_sec  = 30
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/"
    port         = 80
  }
}

# mig -- use google_compute_region_instance_group_manager for a regional mig
# resource "google_compute_instance_group_manager" "mig" {
#   name               = "web-server-mig"
#   base_instance_name = "web-server"
#   zone               = "us-central1-a"

#   version {
#     instance_template = google_compute_instance_template.template.id
#   }

#   target_size = 3

#   auto_healing_policies {
#     health_check      = google_compute_health_check.healthcheck.id
#     initial_delay_sec = 300
#   }
# }
resource "google_compute_region_instance_group_manager" "mig" {
  name                      = "web-server-mig"
  base_instance_name        = "web-server"
  region                    = var.region
  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = 3

  auto_healing_policies {
    health_check      = google_compute_health_check.healthcheck.id
    initial_delay_sec = 300
  }
}
# autoscaling
# attache mig and use google_compute_autoscaler or google_compute_region_autoscaler resource
