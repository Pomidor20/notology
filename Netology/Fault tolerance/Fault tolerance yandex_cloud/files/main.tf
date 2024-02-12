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
  zone                     = var.zone
}

####### NETWORK ###########

resource "yandex_vpc_network" "fullnet" {
  name = "fullnet"
}

resource "yandex_vpc_subnet" "subnet" {
  zone           = var.zone
  network_id     = yandex_vpc_network.fullnet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
  name           = "my_sub"
}
resource "yandex_vpc_address" "addr" {
  count = var.counts
  name = "whiteip-${count.index}"
  external_ipv4_address {
    zone_id = var.zone
  }
}

####### COMPUTE ###########

resource "yandex_compute_instance" "pc" {
  count = var.counts
  hostname    = "os-${count.index}"
  name        = "oc-${count.index}"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      size     = 5
      image_id = "fd8lmueoqum660atdd5r"
    }

  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat = "true"
    nat_ip_address = yandex_vpc_address.addr[count.index].external_ipv4_address.0.address
  }

  metadata = {
    ssh-keys = "pomidor20:${file("./id_ed25519.pub")}"
    serial-port-enable = 1
    user-data = "${file("./cloud-init.txt")}"
  }
}

####### TARGET GROUP ###########

resource "yandex_lb_target_group" "tg-ngx" {
  name      = "target-group"
  

  dynamic target {
    for_each = [for vm in yandex_compute_instance.pc : {
      address = vm.network_interface.0.ip_address
      subnet_id = vm.network_interface.0.subnet_id
    }
    ]
    content{
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }
}

####### BALANSER ###########
resource "yandex_lb_network_load_balancer" "bl-ngx" {
  name = "my-nlb-ngx"

  listener {
    name = "my-listener-ngx"
    port = 8080
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.tg-ngx.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}



####### OUTPUT ###########
output "lb-ip" {
  value = yandex_lb_network_load_balancer.bl-ngx.listener.*.external_address_spec[0].*.address
}

output "white-ip" {
  value = yandex_compute_instance.pc[*].network_interface.*.nat_ip_address
}