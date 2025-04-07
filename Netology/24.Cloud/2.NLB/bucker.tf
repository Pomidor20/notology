
# Создание сервисного аккаунта

resource "yandex_iam_service_account" "bucketuser" {
  folder_id = var.folder_id
  name = "bucketuser"
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "sa-bucketuser" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.bucketuser.id}"
}

# Создание статического ключа доступа

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.bucketuser.id
  description        = "static access key for object storage"
}

# Создание бакета с использованием статического ключа
# https://yandex.cloud/ru/docs/storage/operations/buckets/bucket-availability
resource "yandex_storage_bucket" "pomidorbucket" {
  folder_id             = var.folder_id
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = "pomidorbucket"
  default_storage_class = "standard"
  max_size              = 1073741824
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
}