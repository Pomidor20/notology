output "all" {
  value = {
    external_ip = {
      for vm_name, vm in yandex_compute_instance.eachvms : vm_name => vm.network_interface[0].nat_ip_address
    }
  }
}