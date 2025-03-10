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

 ####### Творим непонятное и создаем list(object


 variable "eachVM" {
  type = list(object({
    vm_name = string
    cpu  = number
    ram = number
    disk_volume = number
    fraction    = number
  }))
  default = [ 
   {
    vm_name = "minik8s-server"
    cpu  = 4
    ram = 4
    disk_volume = 20
    fraction    = 5
  },
  {
    vm_name = "client"
    cpu  = 2
    ram = 4
    disk_volume = 30
    fraction    = 5 
  }

  ]   
 }

