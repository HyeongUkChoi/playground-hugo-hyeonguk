resource "google_compute_network" "vpc-iac-hugo" {
  name                    = "vpc-iac-hugo"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sbn-iac-hugo" {
  name          = "sbn-iac-hugo"
  ip_cidr_range = "10.0.1.0/24"
  region        = "${var.region}"
  network       = google_compute_network.vpc-iac-hugo.self_link
}

resource "google_compute_address" "pubip-vm-an3-jenkins-ip" {
  name   = "pubip-vm-an3-jenkins-ip"
  region = "${var.region}"
}


resource "google_compute_firewall" "allow_all_outbound" {
  name    = "allow-all-outbound"
  network = google_compute_network.vpc-iac-hugo.self_link

  allow {
    protocol = "all"
  }

  direction = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh_inbound" {
  name    = "allow-ssh-inbound"
  network = google_compute_network.vpc-iac-hugo.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction = "INGRESS"
  source_ranges = ["218.154.69.16/32", "35.235.240.0/20"]
  target_tags = ["nt-fr-vm-common"]
}


resource "google_compute_firewall" "allow_jenkins_inbound" {
  name    = "allow-jenkins-inbound"
  network = google_compute_network.vpc-iac-hugo.self_link

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  direction = "INGRESS"
  source_ranges = ["218.154.69.16/32", "35.235.240.0/20"]
  target_tags = ["nt-fr-vm-jenkins"]
}