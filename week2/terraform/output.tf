output "vm_external_ip" {
  value = google_compute_instance.lab2_instance.network_interface[0].access_config[0].nat_ip
}

output "vm_url" {
  value = "http://${google_compute_instance.lab2_instance.network_interface[0].access_config[0].nat_ip}"
}
