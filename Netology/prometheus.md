## 
## Подготовительный этап
- Устанавливаем wget.Требуется для скачивания ахива с прометиусом.
```

```
```
apt install wget
```
- Переходим в любую папку и качаем архив с прометиусом.Далее извлекаем его из архива
```
cd /opt/
wget https://github.com/prometheus/prometheus/releases/download/v2.51.0-rc.0/prometheus-2.51.0-rc.0.linux-amd64.tar.gz
```
- Создаем пользователя от имени которого дальше будет работать прометиус.
 ```
 useradd --no-create-home --shell /bin/false prometheus
 ```
- 
## Установка
- После проделанных шагов выше, нужно вытащить все данные из архива.Делаем это все через tar -xzf.
```
tar -zxf prometheus-2.51.0-rc.0.linux-amd64.tar.gz
cd ./prometheus-2.51.0-rc.0.linux-amd64
```

> [!NOTE]  
> Сожержимое извлеченного архива с описанием  
> console_libraries - директория, которая содержит библиотеки для html шаблонов;  
> consoles - директория, содержащая шаблоны html страниц для веб-интерфейса;   
> prometheus - исполняемый файл Prometheus сервера;  
> prometheus.yml - конфигурационный файл Prometheus;  
> promtool - утилита для проверки конфигурации, работы с TSDB и получения метрик;  

### Установка через распаковку архива.Есть 2 варианта - распихиватьв се по своим папкам или все держать в 1 папке и запусать от туда. 
## Если в демоне меняешь порт, то так же меняй его в файле конфига
### Для первого варианта нужно создать диерктории и скопировать в них файлы из изылеченного архива:
```
mkdir /etc/prometheus
mkdir /var/lib/prometheus
cp prometheus promtool /usr/local/bin/
cp -R ./console_libraries/ /etc/prometheus/
cp -R ./consoles/ /etc/prometheus/
cp prometheus.yml /etc/prometheus/
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
```
 - Далее создаем демона
   ```
   nano /etc/systemd/system/prometheus.service

   [Unit] 
   Description=Prometheus Service Netology Lesson 9.4 
   After=network.target 
   [Service] 
   User=prometheus 
   Group=prometheus 
   Type=simple 
   ExecStart=/usr/local/bin/prometheus \ 
   --config.file /etc/prometheus/prometheus.yml \ 
   --storage.tsdb.path /var/lib/prometheus/ \ 
   --web.console.templates=/etc/prometheus/consoles \ 
   --web.console.libraries=/etc/prometheus/console_libraries 
   ExecReload=/bin/kill -HUP $MAINPID Restart=on-failure 
   [Install] 
   WantedBy=multi-user.target

   systemctl daemon-reload
   systemctl start prometheus
   ```
### Для второго варианта вс находится уже в извлеченной папке и мы только создаем демона:
   ```
   mkdir /opt/prometheus
   cp -R ./ /opt/prometheus
   chown  prometheus:prometheus -R /opt/prometheus/
   nano /etc/systemd/system/prometheus.service
   
   [Unit]
   Description=Prometheus
   Wants=network-online.target
   After=network-online.target
   
   [Service]
   User=prometheus
   Group=prometheus
   ExecStart=/opt/prometheus/prometheus \
       --config.file=/opt/prometheus/prometheus.yml \
       --storage.tsdb.path=/opt/prometheus/data \
       --web.console.templates=/opt/prometheus/consoles \
       --web.console.libraries=/opt/prometheus/console_libraries
   ExecReload=/bin/kill -HUP $MAINPID Restart=on-failure 
   [Install]
   WantedBy=default.target

   systemctl daemon-reload
   systemctl start prometheus
   ```

## Настройка  

## Полезная информация  

- Посмотерть метрики 
```
http://127.0.0.1:9090/metrics
```

- основные ключи запуска Prometheus:  
 
 --config.file="prometheus.yml" - какой конфигурационный файл использовать;  
 --web.listen-address="0.0.0.0:9090" - адрес, который будет слушать встроенный веб-сервер;  
 --web.enable-admin-api - включить или отключить административный API через веб-интерфейс;  
 --web.console.templates="consoles" - путь к директории с шаблонами html;  
 --web.console.libraries="console_libraries" - путь к директории с библиотеками для шаблонов;  
 --web.page-title - заголовок веб-страницы (title);  
 --web.cors.origin=".*" - настройки CORS для веб-интерфейса;  
 --storage.tsdb.path="data/" - путь для хранения time series database;  
 --storage.tsdb.retention.time - время хранения метрик по умолчанию 15 дней, все, что старше, будет удаляться;  
 --storage.tsdb.retention.size - размер TSDB, после которого Prometheus начнет удалять самые старые данные;  
 --query.max-concurrency - максимальное одновременное число запросов к Prometheus через PromQL;  
 --query.timeout=2m - максимальное время выполнения одного запроса;  
 --enable-feature - флаг для включения различных функций, описанных здесь;  
 --log.level - уровень логирования.  

