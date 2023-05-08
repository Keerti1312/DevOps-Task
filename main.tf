//create a vpc
resource "google_compute_network" "vpc_network" {
  project                 ="${ var.project-id}"
  name                    = "${var.cluster-name}-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}


//creates firewall rule
resource "google_compute_firewall" "firewall_name" {
  name    = "${var.cluster-name}-firewall"
  network = google_compute_network.vpc_network.id
  project = var.project-id

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  //source_tags = ["web"]
  target_tags = ["sample"]
  source_ranges = ["0.0.0.0/0"]
}


//create a subnet
resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.cluster-name}-subnet"
  ip_cidr_range = "${var.subnet-cidr}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
  project       = "${var.project-id}"
  private_ip_google_access = true
}

//create a kubernetes cluster
resource "google_container_cluster" "cluster" {
  name                    = "${var.cluster-name}"
  project                 = "${var.project-id}"
  network                 = google_compute_network.vpc_network.id
  subnetwork              = google_compute_subnetwork.subnetwork.id
  location                = "${var.zone}"
  remove_default_node_pool = "true"
  initial_node_count = 1
}

//create a service account
resource "google_service_account" "gke-sa" {
  account_id        = "${var.cluster-name}-node-sa"
  display_name      = "GKE task Service Account"
  project           = "${var.project-id}"
}


//create a node pool
resource "google_container_node_pool" "nodepool_standard" {
  name       = "${var.cluster-name}-nodepool"
  location   = "${var.zone}"
  project = "${var.project-id}"
  cluster    = google_container_cluster.cluster.name
  node_count = "1"

  node_config {
    machine_type = "e2-standard-2"
    disk_type    = "pd-standard"
    disk_size_gb = 20
    // Use the cluster created service account for this node pool
    service_account = google_service_account.gke-sa.email

    // Use the minimal oauth scopes needed
    oauth_scopes = [
    "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      cluster = "${var.cluster-name}"
    }

    // Enable workload identity on this node pool
    #workload_metadata_config {
    #  mode = "GKE_METADATA"
    #}
  }

  // Repair any issues but don't auto upgrade node versions
  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  depends_on = [
    google_container_cluster.cluster
  ]
}

