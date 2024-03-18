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
## Установка
### Установка через пакетный менеджер
- После проделанных шагов выше, нужно вытащить все данные из архива.Делаем это все через tar -xzf.
```
tar -zxf prometheus-2.51.0-rc.0.linux-amd64.tar.gz
```
 
> [!NOTE]  
> Сожержимое извлеченного архива с описанием  
> console_libraries - директория, которая содержит библиотеки для html шаблонов;  
> consoles - директория, содержащая шаблоны html страниц для веб-интерфейса;   
> prometheus - исполняемый файл Prometheus сервера;  
> prometheus.yml - конфигурационный файл Prometheus;  
> promtool - утилита для проверки конфигурации, работы с TSDB и получения метрик;  


## Настройка  

## Полезная информация  

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

