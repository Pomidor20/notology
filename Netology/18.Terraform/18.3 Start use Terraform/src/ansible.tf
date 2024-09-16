#templatefile(path, vars)
resource "local_file" "hostcfg" {
  content = templatefile("${path.module}/inventory.tftpl", 
  { 
    webservers = yandex_compute_instance.default
    dbservers = yandex_compute_instance.eachvms
    storageservers = yandex_compute_instance.manydisk
  } )
  filename = "${abspath(path.module)}/hosts.ini"
}