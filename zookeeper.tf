provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

resource "google_compute_address" "zookeeperip" {
  name   = "${var.zookeeper_instance_ip_name}"
  region = "${var.zookeeper_instance_ip_region}"
}


resource "google_compute_instance" "zookeeper" {
  name         = "${var.instance_name}"
  machine_type = "n1-standard-2"
  zone         = "us-east1-b"

  tags = ["name", "zookeeper", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.zookeepervpc}"
    subnetwork = "${var.zookeepersub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.zookeeperip.address}"
    }
  }
  metadata = {
    name = "zookeeper"
  }

  metadata_startup_script = "sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/Diksha86/zookeeper.git; cd zookeeper ; sudo chmod 777 *; sudo sh zookeeper.sh"
}
