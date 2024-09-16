output "web" {
  value = {
   instance_name =  yandex_compute_instance.default[*].name
   external_ip = yandex_compute_instance.default[*].network_interface.0.nat_ip_address
   fqdn = yandex_compute_instance.default[*].fqdn
  }
}
