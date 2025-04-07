resource "yandex_iam_service_account" "instance-sa" {
  name        = "instance-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.instance-sa.id}"
}


resource "yandex_compute_instance_group" "hw-3" {
  name               = "nlb-vm-group"
  folder_id          = var.folder_id
  service_account_id = "${yandex_iam_service_account.instance-sa.id}"
  instance_template {
    platform_id = "standard-v1"
    resources {
      core_fraction = 20
      memory        = 2
      cores         = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd877etbgpf7ho8og029"
        type     = "network-ssd"
        size     = 10
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.develop.id}"
      subnet_ids = ["${yandex_vpc_subnet.develop.id}"]
      nat        = true
    }

    metadata = {
    ssh-keys = "snake:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDiBXjuIn6mkJgYLkBwhxtcbTTqAWFrcsLbAwIn+sp/A"
    serial-port-enable = "1"
    user-data  = <<EOF
#!/bin/bash
cd /var/www/html
echo '<html><head><title>Victory</title></head> <body><h1>Hello!</h1><img src="http://pomidorbucket.website.yandexcloud.net/victory.jpg"/></body></html>' > index.html
EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name = "target-group-nlb"
  }
}
