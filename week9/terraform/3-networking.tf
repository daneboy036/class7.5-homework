# subnets
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet"
  ip_cidr_range            = "10.0.0.0/18"
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true # allow private instances to use google api and services even without a public ip

  depends_on = [
    google_compute_network.vpc
  ]
}

# router -- CloudRouter used to exchange routes not to actually forward traffic, do nat...
resource "google_compute_router" "router" {
  name    = "router"
  region  = "us-central1"
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }

  depends_on = [
    google_compute_network.vpc
  ]
}
# nat
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = "us-central1"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" # only allow nat for specific subnets
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat_ip.self_link]

  depends_on = [
    google_compute_router.router

  ]
}

# ip for nat
resource "google_compute_address" "nat_ip" {
  name         = "nat-ip"
  region       = var.region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [
    google_project_service.compute
  ]
}

# firewall rules 
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # https://docs.cloud.google.com/load-balancing/docs/health-check-concepts#ip-ranges
  source_ranges = [
    #"0.0.0.0/0",
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  depends_on = [
    google_compute_network.vpc
  ]

  target_tags = ["web-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }


  source_ranges = [
    "0.0.0.0/0",
    #"35.235.240.0/20"
  ]

  depends_on = [
    google_compute_network.vpc
  ]

  target_tags = ["web-server"]
}
