# Разбираем Docker Compose файл
```
version: "3.8"
services:
  netology-db: # Имя Сервиса
    image: postgres:latest # Используем образ PostgreSQL
    container_name: GubochkinA-netology-db
    ports: # Порты, которые мы пробрасываем с нашего докер сервера внутрь контейнера
    - 5432:5432
    volumes: # Папка, которую мы пробросим с докер сервера внутрь контейнера
    - /opt/postgres/pg_data:/var/lib/postgresql/data/pgdata
    environment: # Переменные среды
      POSTGRES_PASSWORD: Gubochkin12!3!! # Задаём пароль от пользователя postgres
      POSTGRES_DB: gubochkin_db # БД которая сразу же будет создана
      PGDATA: /var/lib/postgresql/data/pgdata # Путь внутри контейнера, где будет папка pgdata
    networks:
      gubochkin.A.U-my-netology-hw:  # Подключаем контейнер к сети
        ipv4_address: 172.22.0.2  # Задаем статический IP-адрес для контейнера.
        aliases: # Как другие контейнеру будут к нему обращаться
          - netology-db
    restart: always
             #no: политика перезапуска по умолчанию. Он не перезапускает контейнер ни при каких обстоятельствах.
             #always: политика всегда перезапускает контейнер до его удаления.
             #on-failure: политика перезапускает контейнер, если код выхода указывает на ошибку.
             #unless-stopped: политика перезапускает контейнер независимо от кода выхода, но прекращает перезапуск при остановке или удалении
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: gubochkin-pgadmin
    ports:
    - 61231:80
    environment: # Переменные среды
      PGADMIN_DEFAULT_EMAIL: gubochkin@ilove-netology.com
      PGADMIN_DEFAULT_PASSWORD: 123 # Задаём пароль от пользователя postgres
    depends_on:
    - netology-db
    networks:
      gubochkin.A.U-my-netology-hw:  # Подключаем контейнер к сети
        ipv4_address: 172.22.0.3  # Задаем статический IP-адрес для контейнера.
        aliases: # Как другие контейнеру будут к нему обращаться
          - pgadmin
    restart: always
  zabbi-srv: #Имя Сервиса тут запускам zabbixserver
    image: zabbix/zabbix-server-pgsql:latest
    container_name: gubochkin-zabbix-netology
    ports:
    - 10051:10051
    depends_on:
    - netology-db
    links:
    - netology-db
    environment: # Переменные среды
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: 'Gubochkin12!3!!'
    networks:
      gubochkin.A.U-my-netology-hw:  # Подключаем контейнер к сети
        ipv4_address: 172.22.0.4  # Задаем статический IP-адрес для контейнера.
        aliases: # Как другие контейнеру будут к нему обращаться
          - zabbi-srv
    restart: always
  zabbi-gui: #Имя Сервиса тут запускам zabbixserver
    image: zabbix/zabbix-web-apache-pgsql:latest
    container_name: gubochkin-netology-zabbix-frontend
    ports:
    - 443:8443
    - 80:8080
    depends_on:
    - zabbi-srv
    links:
    - netology-db
    - zabbi-srv
    environment: # Переменные среды
      DB_SERVER_HOST: '172.22.0.2'
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: 'Gubochkin12!3!!'
      ZBX_SERVER_HOST: "zabbix_gui"
      PHP_TZ: "Europe/Moscow"
    networks:
      gubochkin.A.U-my-netology-hw:  # Подключаем контейнер к сети
        ipv4_address: 172.22.0.5  # Задаем статический IP-адрес для контейнера.
        aliases: # Как другие контейнеру будут к нему обращаться
          - zabbi-gui
    restart: always

networks:
  gubochkin.A.U-my-netology-hw: # Имя сети
    driver: bridge # Можеть быть bridge(что то типо NAT),host(изолированная,контейнеры видят только друг друга и не выходит в мир),none (как бы есть и нет)
    ipam: #IPAM расшифровывается как "IP Address Management" (Управление IP-адресами).Управляет настройками IP адресов
      config:
      - subnet: 172.22.0.0/24

```

### Удаляем все образа и Имиджи
```
docker rmi $(docker images -aq)
docker rm $(docker ps -aq)
```

#### environment
Их можно указывать не в файле compose,а выносить наружу.К примеру:
```
version: "3.8"
services:
  netology-db
  env_file:
  - .env_file
```

А уже содержимое .env_file:
ключ = значение
POSTGRES_PASSWORD = 123

# Ссылки в помощь
https://docs.docker.com/compose/networking/
