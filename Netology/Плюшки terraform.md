## Циклы
 ### Динамические блоки
```
   
provider "aws" {
    region = "eu-central-1"
}


resource "aws_security_group" "mywebserver" {
  name = "Dynamic Security Group"
    dynamic "ingress" {
      for_each = ["80", "443", "8080", "1541", "9092"]
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

      }
    }
 
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr blocks =
      ["10.10.0.0/16"]
    }
```

  ### For_each
  - Если мы случайно обернем наша пееременные в type list(object({}) - то нам как Оленям прийдет все прикодить к map(Нам это реально может понадобиться когда у нас в будут повторящиеся данные, тк map использует только уникальные).Ниже пример как выглядят данные в list(object({}) и map(object({})

   - list(object({})
     ```
           variable "each_vm" {
             type = list(object({
               vm_name     = string
               cpu         = number
               ram         = number
               disk_volume = number
             }))
             default = [
               { vm_name = "main",    cpu = 4, ram = 8,  disk_volume = 100 },
               { vm_name = "replica", cpu = 2, ram = 4,  disk_volume = 50  }
             ]
           }
     ```
   - map(object({})
     ```
              variable "each_vm" {
                type = map(object({
                  cpu         = number
                  ram         = number
                  disk_volume = number
                }))
                default = {
                  "main"    = { cpu = 4, ram = 8,  disk_volume = 100 },
                  "replica" = { cpu = 2, ram = 4,  disk_volume = 50  }
                }
              }
              
     ```
   -  

- В выражении count = var.enable_web ? 1 : 0, происходит использование условного оператора (тернарного оператора) для определения значения переменной count в зависимости от значения переменной var.enable_web. Давайте разберем это выражение:
  Название «тернарный» произошло от латинского ternarius – тройной. Оператор принимает три аргумента. Если первый аргумент истина, то возвращается второй аргумент, если ложь, то возвращается третий.
  Синтаксис оператора
  <условие> ? <аргумент 2> : <аргумент 3>


- Мы хотим спрятать сенсетивные данные,тогда нам надо указать sensitive = true,пример
```
variable "database_password" {
type = string
sensitive = true
}
```
- Переменные окружения Можно задавать и в хостовой системе, для этого нужно передать в приставку к переменной TF_VAR_, например
```
Формат: export TF_VAR_image_name = "ubuntu-2004-lts"
Префикс TF_VAR_ отбрасывается
Безопасная аутентификация для yandex provider:
содержимое ~/.bashrc
export TF_VAR_yc_token = $(yc iam create-token)
код terraform:
provider "yandex" {
token = var.yc_token
cloud_id = var.yc_cloud_id
folder_id = var.yc_folder_id
zone = "ru-central1-a"
```
- файлы переменных
Храним ключ знечение:

image_name = "ubuntu-2004-lts"
```
  terraform.tfvars — файл по умолчанию   
 *.auto.tfvars — именованные файлы.Тут можно использовать db.auto.tfvars.Успользуется когда хотим делать именные файлы для варсов.   
```
- Передаем вручную пеерменные.
  ```
  terraform apply -var-file=./develop/env.tfvars
  terraform apply -var-file=./prod/env.tfvars -var-file=/prod/additional.tfvars
  ```
- Когда у переменной нужно понять какой тип использовать
  ```
  type(var.тут значение перерменной)
  ```
- Посмотреть состояние из стета определенной вещи
  ```
  terraform state show google_container_cluster.cluster-staging-main
  ```
- 
