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

- Установить консоль Яндекс Клауда (yc)[^1]
  ```
  curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
  ```

- Нужно получить токен на подключение консоли yc к yc по ссылке из пункта 1.1
https://cloud.yandex.com/en/docs/cli/quickstart#install
 
- Инициализируем консоль yc и вставляем токен из пункта выше.
```
yc init

```
- Далее выбираем облако к которому будем подключаться
- Выбираем папку по усолчанию в этом облаке
- Говорим нужно ли нам выбрать зону по умолчанию и выбираем нужную зону
- Создаем сервис-аккаунт
  ```
  yc iam service-account create ИМЯ
  yc 
  ```
- Назначаем сервис-аккаунту роли edit
```
yc iam service-account list # посмеотреть все сервис акки
yc resource-manager folder list-access-bindings default # Посмотреть права на папку в облаке
yc resource-manager folder add-access-binding default --role editor --subject serviceAccount:тут ID аккаунта
```
- Создаем токен для подлючения сервистного аккаунта к облаку
  ```
  yc iam key create --service-account-name ИМЯ --output key.json
  ```
- 
- Создать файл .terraform в профиле пользователя [^2]
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
  token     = "<OAuth или статический ключ сервисного аккаунта>"
  service_account_key_file = руть к файлу JSON сервис аккаунта
  cloud_id  = "ИД облака"
  folder_id = " ИД папки"
  zone      = "ru-central1-b"
}

```
- Для создания VN используем https://terraform-provider.yandexcloud.net//Resources/compute_instance
- 
### Полезные ссылки и сноски
- описание языка https://developer.hashicorp.com/terraform/language
- описание функций https://developer.hashicorp.com/terraform/language/expressions/strings#interpolation
- backend https://ru.hexlet.io/courses/terraform-basics/lessons/remote-state/theory_unit
- https://developer.hashicorp.com/terraform/language/resources
- https://habr.com/ru/companies/otus/articles/696694/
- 
[^1]: https://cloud.yandex.com/en/docs/cli/quickstart#install
[^2]: https://developer.hashicorp.com/terraform/cli/config/config-file#explicit-installation-method-configuration
