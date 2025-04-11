
#https://yandex.cloud/ru/docs/storage/tutorials/static/terraform#manual_1
# 
# Создание сервисного аккаунта

resource "yandex_iam_service_account" "bucketuser" {
  folder_id = var.folder_id
  name = "bucketuser"
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "sa-bucketuser" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.bucketuser.id}"
}
resource "yandex_resourcemanager_folder_iam_member" "sa-encrypter-decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.bucketuser.id}"
}
# Создание статического ключа доступа

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.bucketuser.id
  description        = "static access key for object storage"
}
# Создание KMS ключа

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "example-symetric-key"
  description       = "Pomidorkinkey"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
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

#  https {
#    certificate_id = yandex_cm_certificate.pomidorkincert.id
#  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
       sse_algorithm     = "aws:kms"
      }
  
    }
  }
#  depends_on = [yandex_cm_certificate.pomidorkincert]
}
