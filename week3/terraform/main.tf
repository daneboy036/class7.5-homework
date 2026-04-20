resource "google_compute_firewall" "firewall_allow_http" {
  name    = "firewall-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "lab2_instance" {
  name         = var.vm_name
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {} # External IPs that can access teh instance over the internet
  }

  metadata = {
    student_name = var.student_name
  }

  metadata_startup_script = file("./startup-script.sh")

  tags = ["web", "hw-week2"]
}
