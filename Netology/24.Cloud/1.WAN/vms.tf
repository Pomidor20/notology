resource "yandex_compute_disk" "my_disk" {
  for_each = toset(var.disk_name)

  name     = each.value
  type     = "network-ssd"
  zone     = var.default_zone_a
  image_id = var.image_id[index(var.disk_name, each.value)]
}

resource "yandex_compute_instance" "eachvms" {
  for_each = { for vm in var.eachVM : vm.vm_name => vm }

  hostname    = each.value.vm_name
  name        = each.value.vm_name
  platform_id = "standard-v1"
  zone        = var.default_zone_a

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.fraction
  }

  boot_disk {
    disk_id = yandex_compute_disk.my_disk[each.value.vm_name].id
  }

  network_interface {
    subnet_id = each.value.vm_name == "WAN" ? yandex_vpc_subnet.my-subnet-public.id : yandex_vpc_subnet.my-subnet-private.id 
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat       = each.value.vm_name == "WAN" ? true : false
  }

  metadata = {
    serial-port-enable = 1
    user-data         = file("${path.module}/meta-${each.value.vm_name}.yaml")
  }
  depends_on = [yandex_vpc_subnet.my-subnet-private] 
}