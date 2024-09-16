## Качаем провов ##

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.127.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

## Данные для рандома ##

resource "random_password" "rpass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "pass" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

provider "yandex" {
#  token                    = "auth_token_here"
  service_account_key_file = "key.json"
  cloud_id                 = "b1g21olqde5458a8pofk"
  folder_id                = "b1gc2qgcmi2b4jojgchd"
  zone                     = "ru-central1-a"
}

## СОЗДАЕМ ВСЕ ЧТО СВЯЗАНО С YA ##
## Network ##

resource "yandex_vpc_network" "hw-terra" {
  name = "hw-terra"
}

resource "yandex_vpc_subnet" "subnet-hw-terra" {
  name           = "subnet-hw-terra"
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.10.0.0/24"]
  network_id     = "${yandex_vpc_network.hw-terra.id}"
}

## DISK ##
resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = "20"
  image_id = "fd8q49fvba72foa1ol22"
}

## VM ##
resource "yandex_compute_instance" "HW-1" {
  name                      = "debian-vm"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"


  scheduling_policy {

    preemptible = true # Сделать VM прерываемой
  }

  resources {
    core_fraction = 20 # Гарантированная доля vCPU
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-hw-terra.id}"
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
#   ssh-keys           = "debian:${file("~/.ssh/id_rsa.pub")}"
    user-data = "${file("./cloud-init.yaml")}"
  }

}

## ПИЛИМ ДОКЕРА ##
provider "docker" {
  host = "ssh://test@${yandex_compute_instance.HW-1.network_interface.0.nat_ip_address}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no"]
}
# Pulls the image
resource "docker_image" "mysql" {
  name = "mysql:8"
}

# Create a container
resource "docker_container" "mysqlcon" {
  image = docker_image.mysql.image_id
  name  = "mysqlcon"
  restart = "always"
  start = true

  ports {
    internal = 3306
    external = 3306
  }
  
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.rpass.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.pass.result}",
    "MYSQL_ROOT_HOST=%",
  ]
}

## OUTPUT ##
output "IP1" {

  value = yandex_compute_instance.HW-1.network_interface.0.nat_ip_address
}
