terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.8.4"
}

provider "yandex" {
#  token     = var.token
  service_account_key_file = file("~/.authorized_key.json")
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone_a
}

resource "yandex_compute_disk" "my_disk" {
  for_each = var.disks

  name     = each.value.name
  type     = "network-ssd"
  zone     = var.default_zone_a
  image_id = each.value.image_id
  size     = "20"
}