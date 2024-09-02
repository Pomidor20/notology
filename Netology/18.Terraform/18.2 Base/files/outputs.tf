output "web" {
  value = {
   instance_name =  yandex_compute_instance.platform.name
   external_ip = yandex_compute_instance.platform.network_interface.0.nat_ip_address
   fqdn = yandex_compute_instance.platform.fqdn
  }
}

output "DB" {
  value = {
   instance_name =  yandex_compute_instance.platform1.name
   external_ip = yandex_compute_instance.platform1.network_interface.0.nat_ip_address
   fqdn = yandex_compute_instance.platform1.fqdn
  }
}