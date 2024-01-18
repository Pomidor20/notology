## Elasticsearch
```
apt install apt-transport-https gpg openjdk-17-jre
```

 - качаем ключ репозитория
```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```

- Качаем репозиторий и устанавливаем его
```
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-8.x.list
```
- Устанавливаем elasticsearch
```
apt update && apt-get install elasticsearch
```

- Настраиваем файл 
```
cluster.name: my-elk
node.name: node-1
discovery.type: single-node
network.host: 192.168.0.1
http.port: 9200

```
>[!NOTE]
>Обязательно комментировать последнюю строчку #cluster.initial_master_nodes: ["elk"]  
>https://discuss.elastic.co/t/unable-to-start-elastic-service-setting-cluster-initial-master-nodes-is-not-allowed-when-discovery-type-is-set-to-single-node/314375  
>
>
>#Enable encryption and mutual authentication between cluster nodes  
>xpack.security.transport.ssl:  
>  enabled: true  
>  verification_mode: certificate  
>  keystore.path: certs/transport.p12  
>  truststore.path: certs/transport.p12  
>#Create a new cluster with the current node only  
>#Additional nodes can still join the cluster later  
>#cluster.initial_master_nodes: ["elk"]  

- Генерим пароль пользователя
```
cd /usr/share/elasticsearch/bin/
./elasticsearch-reset-password --interactive -u elastic

```
## КИБАНА

```
apt install kibana

vi /etc/kibana/kibana.yml 
```
 - Меняем
```
server.host: 192.168.0.1
elasticsearch.hosts: ['https://192.168.0.1:9200']
```

- Идем на сервер Эластика за токеном
```
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
```

- Открываем сайт Кибаны и вставляем токен,который получили выше.
```
http://192.168.0.1:5601/
```
- Откроется окно с вводом проверочного кода. Возвращаемся на сервер с кибаной и вводим команду:
```
/usr/share/kibana/bin/kibana-verification-code
```
 - Чтобы запустить несколько экземпляров Kibana на одном узле, необходимо указать путь к файлу конфигурации каждого из них. Для этого используется ключ -c:

bin/kibana -c <путь_к_файлу_конфигурации_#1>
bin/kibana -c <путь_к_файлу_конфигурации_#2>



## Logstash
```
apt install logstash
```
- Настройки для логстэша хранятся в каталоге /etc/logstash/conf.d в файлах формата JSON. Для конфигурации используются следующие секции:
```
input (входные данные).
filter (фильтры).
output (выходные данные).
```

- Для каждой из них мы создадим свой файл.

```
vi /etc/logstash/conf.d/input.conf

input {
  beats {
    port => 5044
  }
}
```







Открыть консоль в kibana
http://192.168.0.1:5601/app/dev_tools#/console

Состояние кластера    
GET /_cluster/health?pretty   
Состояние ноды
curl -k -X GET 'https://localhost:9200/_nodes?format=yaml' --user "elastic:пароль"

- Настройка очиски и тонкая     
  https://habr.com/ru/companies/domclick/articles/507072/
  
---
https://habr.com/ru/companies/galssoftware/articles/547000/   
https://cloud.vk.com/docs/additionals/cases/cases-logs/case-logging   
https://www.dmosk.ru/instruktions.php?object=elk-ubuntu   
https://habr.com/ru/articles/538974/   
https://habr.com/ru/articles/538840/   
https://www.elastic.co/guide/en/logstash/current/configuration-file-structure.html   
https://habr.com/ru/articles/165059/    
https://github.com/hpcugent/logstash-patterns/blob/master/files/grok-patterns # разбор грока
https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-nginx.html   #filebeats модули и их настройка
