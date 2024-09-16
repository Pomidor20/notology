resource "yandex_compute_disk" "empty-disk" {
  count = 3
  name       = "empty-disk${count.index}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "manydisk" {
  depends_on = [ yandex_compute_disk.empty-disk ]
  hostname    = "storage"
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone
  # 2 Варианта как делать to set или через for
  #for_each = toset(yandex_compute_disk.empty-disk[*].id)

  resources {
    cores  = var.resourceVM.cores
    memory = var.resourceVM.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.empty-disk[*].id)
     content {
      disk_id = "${secondary_disk.value}"
     }
  }  
#      dynamic "secondary_disk" {
#   for_each = "${yandex_compute_disk.storage_1.*.id}"
#          for_each = { for stor in yandex_compute_disk.storage_1[*]: stor.name=> stor }
#              content {
#     disk_id = yandex_compute_disk.storage_1["${secondary_disk.key}"].id
#                disk_id = secondary_disk.value.id
#              }
#  }

  network_interface {
    index  = 1
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = true
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           =  var.metadata.ssh-keys
  }
}



