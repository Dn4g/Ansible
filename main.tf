terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.77.0"
    }
  }
}
provider "yandex" {
  token     = ""
  cloud_id  = ""
  folder_id = ""
  zone      = "" #он же регион
}

// создаем сеть для вдс
resource "yandex_vpc_network" "my-network" {
  name = "my-network"
}

// создаем подсеть для вдс из текущей сети
resource "yandex_vpc_subnet" "my-subnet" {
  name           = "my-subnet-1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.my-network.id
  v4_cidr_blocks = ["10.0.0.0/16"]
}


// создаем VM1 и VM2 - 2vcpu 2ram 20hdd ubuntu 20
// придумать что-нить с циклом, меняется только название

resource "yandex_compute_instance" "vm" {
  count                     = 2
  name                      = "vm${count.index}"
  hostname                  = "vm${count.index}"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ju9iqf6g5bcq77jns" # Ubuntu-20
      size     = 20
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.my-subnet.id
    nat       = true
  }
  metadata = {
    user-data = "${file("metadata.txt")}"
  }

}

resource "yandex_compute_instance" "vm2" {
  name                      = "vm2"
  allow_stopping_for_update = true
  hostname = "vm2"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8j0db3lnmi4g7k93u5" #Centos-8
      size     = 20
    }

  }
  network_interface {
    subnet_id = yandex_vpc_subnet.my-subnet.id
    nat       = true
  }
  metadata = {
    user-data = "${file("metadata.txt")}"
  }
}
