# Установка Docker на Debian

```
apt update

apt install ca-certificates curl gnupg -y

install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install docker-ce docker-ce-cli containerd.io -y


```
Если нужен еще compose
```
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

## Пилим свой имидж
1. Выбираем или создаем папку с прокетом и переходим в нее
1. В этой папке создаем файл с именем Dockerfile
1. Наполняем его и сохраняеи.Пример:

```
FROM httpd:latest
LABEL owner="apache snake"

COPY ./index.html /usr/local/apache2/htdocs/
```
1. Запускаем сборку Имиджа

```
 docker build -t snake .
```
1. Пробегают строки и создается имидж.

```
[+] Building 0.5s (7/7) FINISHED                                                                                                                      docker:default
 => [internal] load build definition from Dockerfile                                                                                                            0.0s
 => => transferring dockerfile: 129B                                                                                                                            0.0s
 => [internal] load .dockerignore                                                                                                                               0.0s
 => => transferring context: 2B                                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/httpd:latest                                                                                                 0.0s
 => [internal] load build context                                                                                                                               0.1s
 => => transferring context: 138B                                                                                                                               0.0s
 => [1/2] FROM docker.io/library/httpd:latest                                                                                                                   0.2s
 => [2/2] COPY ./index.html /usr/local/apache2/htdocs/                                                                                                          0.1s
 => exporting to image                                                                                                                                          0.1s
 => => exporting layers                                                                                                                                         0.0s
 => => writing image sha256:2b6570bd093d824e4e7887a06257f14fe0a2ec18a4947f75f60ce8041e5c0089                                                                    0.0s
 => => naming to docker.io/library/snake    
```
1. Проверям что Имидж создался

```
 docker image ls
```

1. Запускаем контейнер из имиджа. У меня делался апатч  

```
 docker run -dit --name my-running-app -p 8080:80 snake
```
#### Если что то не так пошло провались в контейнер и проверяй))))
```
docker exec -it my-running-app bash
Docker network inspect имя сети
Docker  inspect
```

## Ссылки в помощь
1. https://docs.docker.com/engine/install
1. https://docs.docker.com/engine/reference/commandline/image_rm/
1. https://docs.docker.com/build/guide/intro/
1. https://docs.docker.com/engine/reference/builder/
2. https://github.com/veggiemonk/awesome-docker #Полезный сайт по докеру
