# Начало
## Установка
### C официального сайта:
- Идеи на оф сайт и следуем инстукции https://developer.hashicorp.com/terraform/downloads?product_intent=terraform  
  - Для DEB
    ```
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
    ```
  - Для RPM
    ```
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install terraform
    ```
> [!NOTE]  
> При данном подходе не требуется бинарник перемещать в /usr/...... Установщик сам положит его в  /usr/bin/terraform  

### C Яндекс облака:

- Идем на https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart  
  - Находим там установку из серкала https://hashicorp-releases.yandexcloud.net/terraform/  
  - После скачивания перемещаем бинарник в /usr/local/bin/
    ```
    cp имя скаченного файла /usr/local/bin/terraform
    ```    
    > [!NOTE]  
    > При данном подходе нужно помещать бинарник в /usr/...... После перемещения можно из консоли просто запускать terraform 

### Настройка

Для подключения провайдера yandex.cloud нужно 
- Создать файл .terraform в профиле пользователя [^1]
```
touch ~/.terraformrc
```
- Наполнить файл содержиммым
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
- В папке где будет располагаться проект по терраформу (скрипты и тд), нужно создать файл конфигурации main.tf (имя не важно,главное расшиерние).Я все делаю в хомах пользователя

```
touch ~/main.tf
nano ~/main.tf
```
  - Вставляем код ниже
    ```
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
      required_version = ">= 0.13"
    }
    
    provider "yandex" {
      zone = "ru-central1-b"
    }
    ```
- 
- 
### Полезные ссылки и сноски
- описание языка https://developer.hashicorp.com/terraform/language
- описание функций https://developer.hashicorp.com/terraform/language/expressions/strings#interpolation
- backend https://ru.hexlet.io/courses/terraform-basics/lessons/remote-state/theory_unit
- https://developer.hashicorp.com/terraform/language/resources
- https://habr.com/ru/companies/otus/articles/696694/
[^1]: https://developer.hashicorp.com/terraform/cli/config/config-file#explicit-installation-method-configuration
