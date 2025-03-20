

resource "yandex_compute_instance" "wan" {
  hostname    = "wan"
  name        = "wan"
  platform_id = "standard-v1"
  zone        = var.default_zone_a

  resources {
    cores         = 2
    memory        = 3
    core_fraction = 20
  }

  boot_disk {
    disk_id = yandex_compute_disk.my_disk["wan"].id
  }

  network_interface {
    subnet_id =  yandex_vpc_subnet.my-subnet-public.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat       = true 
  }

  metadata = {
    serial-port-enable = 1
    user-data         = file("${path.module}/meta-WAN.yaml")
  }
}