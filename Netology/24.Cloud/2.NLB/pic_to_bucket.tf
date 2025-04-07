#https://terraform-provider.yandexcloud.net/resources/storage_object
#https://yandex.cloud/ru/docs/storage/operations/objects/upload
# 
# Фото покажется только если перейти по http
# http://pomidorbucket.website.yandexcloud.net/victory.jpg
#
# https://yandex.cloud/ru/docs/tutorials/web/static/terraform#test-site

resource "yandex_storage_object" "uplod_pic" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "pomidorbucket"
  key        = "victory.jpg"
  source     = "./pic/mypic.jpg"
  acl    = "public-read"
  content_type = "image/jpeg"
}
