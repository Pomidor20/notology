### Variables for cloud 
variable "cloud_id" {
  type        = string
  default     = "b1g21olqde5458a8pofk"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gc2qgcmi2b4jojgchd"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


### Variables for network
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}




variable "disks" {
  type = map(object({
    name     = string
    image_id = string
  }))
  default = {
    wan = {
      name     = "wan"    # Lowercase name
      image_id = "fd8l704v1313gha28lj8"
    },
    local = {
      name     = "local" # Lowercase name
      image_id = "fd8kc2n656prni2cimp5"
    }
  }
}
### переменная для vm
#
#variable "LOCAL" {
#  type = string
#  default = "hostname_WAN"
#}
#
#variable "WAN" {
#  type = string
#  default = "WAN"
#}
#
#variable "eachVM" {
#  type = list(object({
#    vm_name  = string
#    cpu      = number
#    ram      = number
#    fraction = number
#  }))
#  default = [
#    { vm_name = "WAN", cpu = 2, ram = 4, fraction = 50 },
#    { vm_name = "LOCAL", cpu = 2, ram = 4, fraction = 50 }
#  ]
#}
#
### переменная для секьюрити груп
variable "security_rules" {
  type = list(object({
    protocol    = string
    description = string
    port        = number
  }))
  default = [
    { protocol = "TCP", description = "ssh", port = 22 },
    { protocol = "TCP", description = "ext-http", port = 80 },
    { protocol = "TCP", description = "ext-https", port = 443 }
  ]
}