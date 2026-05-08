# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "vm" {
  name         = "week8-vm"
  machine_type = "n2-standard-2" # n2 series, standard means balanced and 2 means 2 vCPUs
  zone         = "us-central1-a"

  # this is what they called the root persistent disk
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-10"
      size  = 100 # in gigabytes
    }
  }

  network_interface {
    network = "default"

    access_config {
      # leaving blank will result in an ephemeral ip being created for you
    }
  }

  metadata_startup_script = file("${path.module}/../assets/startup-for-rhel.sh")

  tags = ["http-server"]
}
