resource "yandex_cm_certificate" "pomidorkincert" {
  name    = "pomidorkincert"

  self_managed {
    certificate = file("./cert.pem")
    private_key = file("./key.pem")
  }
}