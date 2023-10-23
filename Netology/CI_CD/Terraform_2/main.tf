terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

variable "token"{
description = "Token to YC"
type = string
}



provider "yandex" {
  token = var.token#<OAuth или статический ключ сервисного аккаунта>
#  service_account_key_file = "key.json"
  cloud_id                 = "b1g21olqde5458a8pofk"
  folder_id                = "b1gc2qgcmi2b4jojgchd"
  zone                     = "ru-central1-b"
}

resource "yandex_compute_instance" "vm" {
  name        = "nginx"
  platform_id = "standard-v2"
  zone        = "ru-central1-b"

  scheduling_policy {

    preemptible = true # Сделать VM прерываемой
  }

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8il24jjf1hg8d4nq7i"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.terra_sub.id
    nat            = true
    nat_ip_address = yandex_vpc_address.myip.external_ipv4_address.0.address
  }

  metadata = {
    serial-port-enable = 1
    user-data = "${file("./meta.txt")}"
  }

}

######### NETWORKS ##############


resource "yandex_vpc_network" "terra" {
  name = "VPC"
}

resource "yandex_vpc_subnet" "terra_sub" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.terra.id
  name           = "my_sub"
}

resource "yandex_vpc_address" "myip" {
  name = "exampleAddress"

  external_ipv4_address {
    zone_id = "ru-central1-b"
  }
}

######### OUTPUTS ##############
output "white_ip" {
	value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}
