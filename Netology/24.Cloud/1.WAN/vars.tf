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

variable "default_zone_a" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

### Variables for network

variable "vpc_name" {
  type = string
  default = "cloud"
}

variable "name_subnet_public" {
  type = string
  default = "my-subnet-public"
}

variable "cidr_public" {
  type = string
  default = "192.168.10.0/24"
}

variable "name_subnet_private" {
  type = string
  default = "my-subnet-private"
}

variable "cidr_private" {
  type = string
  default = "192.168.20.0/24"
}

variable "disk_name" {
  type = list(string)
  default = ["natpc", "workpc"]
}
variable "image_id" {
  type = list(string)
  default = [ "fd8l704v1313gha28lj8", "fd8kc2n656prni2cimp5"]  
}

### переменная для vm

variable "eachVM" {
  type = list(object({
    vm_name  = string
    cpu      = number
    ram      = number
    fraction = number
  }))
  default = [
    { vm_name = "WAN", cpu = 2, ram = 4, fraction = 50 },
    { vm_name = "LOCAL", cpu = 2, ram = 4, fraction = 50 }
  ]
}

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