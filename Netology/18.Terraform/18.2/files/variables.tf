###cloud vars
variable "token" {
  type        = string
  default     = ""
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "nat_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_name_nat" {
  type        = string
  default     = "vpc_nat"
  description = "VPC network & subnet name"
}


### VM's vars ###

variable "vm_web_image_family"{
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family fot install OS"
}

variable "vm_name"{
  type        = map(string)
  default     = {
   vm_web_name = "netology-develop-platform-web"
   vm_db_name = "netology-develop-platform-db"
 
  }
  description = "Name for vm"
}

variable "vm_web_platform_id"{
  type        = string
  default     = "standard-v2"
  description = "platform_id"
}

variable "vm_resource" {
  type        = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  default = {
 
  WEB = {
    cores = 2
    memory = 2
    core_fraction = 5
  }
 
  DB  = {
    cores = 2
    memory = 2
    core_fraction = 20
  description = "resources for vm "
}}
}



###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDiBXjuIn6mkJgYLkBwhxtcbTTqAWFrcsLbAwIn+sp/A"
#  description = "ssh-keygen -t ed25519"
#}

 variable "metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys = string
    })
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDiBXjuIn6mkJgYLkBwhxtcbTTqAWFrcsLbAwIn+sp/A"
  } 
 }