# static ip for load balancer 
# google_compute_address is regional and useful for regional resources liek vms and regional load balancers
# resource "google_compute_address" "lb_ip" {
#   name         = "lb-ip"
#   region       = var.region
#   address_type = "EXTERNAL"
# }
resource "google_compute_global_address" "lb_ip" {
  name         = "lb-ip"
  address_type = "EXTERNAL"
}

# Backend service for the load balancer
resource "google_compute_backend_service" "lb_web_backend" {
  name        = "web-backend-service"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30
  #load_balancing_scheme = "EXTERNAL_MANAGED" # EXTERNAL_MANAGED for global external application load balancer...EXTERNAL and is defaultwould be for classic lb see https://docs.cloud.google.com/load-balancing/docs/backend-service

  health_checks = [google_compute_health_check.healthcheck.id]

  backend {
    group           = google_compute_region_instance_group_manager.mig.instance_group # The fully-qualified URL of an Instance Group or Network Endpoint Group resource. 
    balancing_mode  = "UTILIZATION"
    max_utilization = 0.8 # cpu utilization target for group
    capacity_scaler = 1.0 # 1 means the group will server 100% of its conigured capacity 0 means the group is drained off

  }
  connection_draining_timeout_sec = 300 # time to wait before forcefully terminating connections to an instance that is being removed from the backend service
  log_config {
    enable      = false
    sample_rate = 1.0 # means log all requests when logging is on
  }
}

# URL map -- routes requests to the correct backend
resource "google_compute_url_map" "lb_url_map" {
  name            = "lb-url-map"
  default_service = google_compute_backend_service.lb_web_backend.id

  host_rule { # list of host rules to match against the url
    hosts        = ["*"]
    path_matcher = "main-path-matcher"
  }

  # matches are done on the longest path
  path_matcher {
    name            = "main-path-matcher"
    default_service = google_compute_backend_service.lb_web_backend.id

    path_rule { # switch later
      paths   = ["/tokyo/*"]
      service = google_compute_backend_service.lb_web_backend.id
    }
  }
}

# Target http proxy
# for http use google_compute_target_https_proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "web-http-proxy"
  url_map = google_compute_url_map.lb_url_map.id
}

# forwarding rule -- listens for traffic...forwards it to the proxy which uses the url map to choose the backend service or backend bucket
resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.lb_ip.address
  #load_balancing_scheme = "EXTERNAL_MANAGED"
}

# WAF (cloud armor) if you want it resource: google_compute_security_policy
