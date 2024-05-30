resource "google_compute_network" "" {
  name                    = "vpc-iac-hugo"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "iac-subnet" {
  name          = "iac-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.vpc-iac-hugo
}