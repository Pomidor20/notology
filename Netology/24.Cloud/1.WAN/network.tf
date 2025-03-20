resource "yandex_vpc_network" "mycloud" {
  name = var.vpc_name
  description = "my cloud network"
}

resource "yandex_vpc_subnet" "my-subnet-public" {
  name           = var.name_subnet_public
  description    = "Network for public"
  v4_cidr_blocks = [var.cidr_public]
  zone           = var.default_zone_a
  network_id     = yandex_vpc_network.mycloud.id
}

resource "yandex_vpc_subnet" "my-subnet-private" {
  name           = var.name_subnet_private
  description    = "Network for private"
  v4_cidr_blocks = [var.cidr_private]
  zone           = var.default_zone_a
  network_id     = yandex_vpc_network.mycloud.id
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
  depends_on = [yandex_vpc_network.mycloud]
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.mycloud.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.wan.network_interface[0].ip_address
  }

}