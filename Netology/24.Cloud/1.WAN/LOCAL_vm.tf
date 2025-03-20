resource "yandex_compute_instance" "local" {


  hostname    = "local"
  name        = "local"
  platform_id = "standard-v1"
  zone        = var.default_zone_a

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    disk_id = yandex_compute_disk.my_disk["local"].id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.my-subnet-private.id 
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat       = false
  }

  metadata = {
    serial-port-enable = 1
    user-data         = file("${path.module}/meta-LOCAL.yaml")
  }
  depends_on = [
    yandex_vpc_route_table.nat-instance-route # Ожидаем создания таблицы маршрутов
  ]
}