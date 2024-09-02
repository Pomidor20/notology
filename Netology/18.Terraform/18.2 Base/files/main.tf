resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.nat_route_table.id
}



### ПРОБУЕМ В РОУТЕР ####

resource "yandex_vpc_subnet" "nat_sub" {
  name           = var.vpc_name_nat
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.nat_cidr
}
resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id = var.folder_id
  name = "test-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

 ######## Первая VM WEB ######
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_resource.WEB.cores
    memory        = var.vm_resource.WEB.memory
    core_fraction = var.vm_resource.WEB.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  #  nat       = true
  nat       = false
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           =  var.metadata.ssh-keys
  }

}
  ######## Вторая VM DB ######

  resource "yandex_compute_instance" "platform1" {
  name        = local.vm_db_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vm_resource.DB.cores
    memory        = var.vm_resource.DB.memory
    core_fraction = var.vm_resource.DB.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  #  nat       = true
  nat       = false
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           =  var.metadata.ssh-keys
  }

}


