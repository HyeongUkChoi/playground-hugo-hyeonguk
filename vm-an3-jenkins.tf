resource "google_compute_instance" "vm-an3-jenkins" {
    name            = "vm-an3-jenkins"
    hostname        = "jenkins.hugo"
    machine_type    = "n1-standard-2"
    zone            = "${var.region}-a"

    boot_disk {
      source = google_compute_disk.disk-vm-an3-jenkins-root.self_link
    }

    attached_disk {
      source = google_compute_disk.disk-vm-an3-jenkins-data.self_link
    }

    tags = [
    "nt-fr-vm-common",
    "nt-fr-vm-jenkins"
    ]

    network_interface {
    subnetwork = var.sbn-iac-hugo-selflink
    network_ip  = var.vm-an3-jenkins-ip
    access_config {
        nat_ip = google_compute_address.pubip-vm-an3-jenkins-ip.address
    }
    }

    metadata = {
        ssh-keys = google_compute_project_metadata_item.sshkey.value
    }
    
    allow_stopping_for_update = true
    desired_status = "RUNNING"

    service_account {
      email = "terraform-hugo@playground-hugo-20240408.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }

    labels = var.iac-common-labels
}

resource "google_compute_disk" "disk-vm-an3-jenkins-root" {
    name                      = "disk-vm-an3-jenkins-root"
    type                      = "pd-standard"
    zone                      = "${var.region}-a"
    size                      = 50
    physical_block_size_bytes = 4096
    labels                    = var.iac-common-labels
    image                     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

resource "google_compute_disk" "disk-vm-an3-jenkins-data" {
    name                      = "disk-vm-an3-jenkins-data"
    type                      = "pd-standard"
    zone                      = "${var.region}-a"
    size                      = 50
    physical_block_size_bytes = 4096
    labels                    = var.iac-common-labels
}