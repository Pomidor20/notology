
resource "yandex_compute_instance" "eachvms" {
  for_each = { for vm in var.eachVM : vm.vm_name => vm }
  hostname    = each.value.vm_name
  name        = each.value.vm_name
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = each.value.fraction
  }

  boot_disk {
    initialize_params {
#      image_id = data.yandex_compute_image.ubuntu.image_id
      image_id = "fd870chete5dal4rjlkq"
      size = each.value.disk_volume
    }
  }
  network_interface {
    index  = 1
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }


  metadata = {
   serial-port-enable = 1
   user-data = file("${path.module}/meta-${each.value.vm_name}.yaml")
}
}
