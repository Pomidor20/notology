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
