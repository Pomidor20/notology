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

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


### BLOCk VARIABLE TO VM ####

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "The name of the image family to which this image belongs."
}

variable "countVM" {
  type = number
  default = 2
  description =  "count of Vm"
  
}
variable "resourceVM" {
  type = object({
    cores  = number
    memory = number
  })
  default = {
    cores  = 2
    memory = 4
  }
}
 variable "vm_web_image_family"{
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family fot install OS"
}
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

 ####### Творим непонятное и создаем list(object


 variable "eachVM" {
  type = list(object({
    vm_name = string
    cpu  = number
    ram = number
    disk_volume = number
  }))
  default = [ 
   {
    vm_name = "main"
    cpu  = 2
    ram = 2
    disk_volume = 20  
  },
  {
    vm_name = "replica"
    cpu  = 4
    ram = 4
    disk_volume = 30  
  }
  ]   
 }

