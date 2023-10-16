terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  #  token     = "<OAuth или статический ключ сервисного аккаунта>"
  service_account_key_file = "key.json"
  cloud_id                 = "b1g21olqde5458a8pofk"
  folder_id                = "b1gc2qgcmi2b4jojgchd"
  zone                     = "ru-central1-b"
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
  name = "exampleAddress-${count.index + 1}"
  count = 5
  external_ipv4_address {
    zone_id = "ru-central1-b"
  }
}

resource "yandex_vpc_security_group" "sec_group" {
  name        = "My first secur"
  description = "MY sec group"
  network_id  = "${yandex_vpc_network.terra.id}"

  labels = {
    my-label = "my-label-value"
  }
}


######CREATE VM###########
resource "yandex_compute_instance" "vm" {
  name        = "xyeta-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = "ru-central1-b"
  count = 5

  scheduling_policy {

    preemptible = true # Сделать VM прерываемой
  }

  resources {
    core_fraction = 5 # Гарантированная доля vCPU
    cores         = 2
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8il24jjf1hg8d4nq7i"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.terra_sub.id
    nat            = true
   nat_ip_address = yandex_vpc_address.myip[count.index].external_ipv4_address.0.address
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "debian:${file("~/.ssh/id_rsa.pub")}"
  }




}





################## OUTPUTS  ####################
#output "IP1" {

#  value = yandex_vpc_address.myip.external_ipv4_address.0.address
#}

#output "IP2" {

#  value = yandex_compute_instance.myvm1.network_interface.0.nat_ip_address


#}

#output "text" {
#  value = var.xyeta
#}
