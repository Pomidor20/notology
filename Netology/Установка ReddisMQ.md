## Установка RabbitMQ

### Надо подготовить систему к установке

- Ставим пакеты каоторые нам понялрбятся для установки Кролика
	```
	apt install curl gnupg apt-transport-https -y
	```
	 - curl — программа для отправки http-запросов. Нам нужна для загрузки ключа репозитория.
	 - gnupg — для шифровки и дешифровки цифровых подписей. Нужна для работы с репозиториями.
	 - apt-transport-https — дополнение для возможности использовать репозитории по https.

- Качаем официальные ключи репозиториев.Прошу  обратить внимание - что все установки делаются под рутом.
	```
	curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | gpg --dearmor | tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
	curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-erlang.E495BB49CC4BBE5B.key |  gpg --dearmor |  tee /usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg > /dev/null
	curl -1sLf https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-server.9F4587F226208342.key |  gpg --dearmor |  tee /usr/share/keyrings/rabbitmq.9F4587F226208342.gpg > /dev/null
	```
- Создаем файл с путями репозиториев для кролика.
	```
	tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
	deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bullseye main
	deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bullseye main

	# another mirror for redundancy
	deb [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bullseye main
	deb-src [signed-by=/usr/share/keyrings/rabbitmq.E495BB49CC4BBE5B.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-erlang/deb/ubuntu bullseye main

	## Provides RabbitMQ from a Cloudsmith mirror
	##
	deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bullseye main
	deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa1.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bullseye main

	# another mirror for redundancy
	deb [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bullseye main
	deb-src [signed-by=/usr/share/keyrings/rabbitmq.9F4587F226208342.gpg] https://ppa2.novemberain.com/rabbitmq/rabbitmq-server/deb/ubuntu bullseye main
	EOF
	```
- Обновляем кеш репозиториев
	```
	apt update -y
	```
- Ставим пакеты для Erlang
	```
	apt install -y erlang-base \
                        erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                        erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                        erlang-runtime-tools erlang-snmp erlang-ssl \
                        erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
	```
- Устанавливаем сам сервер RabbitMQ
	```
	apt install rabbitmq-server -y --fix-missing
	```

 ## настройка RabbitMQ

 - Создаем пользователя.
	```
	 rabbitmqctl add_user admin password
 	```	
 - Делаем нашего пользователя администратором
	```
	 rabbitmqctl set_user_tags admin administrator
 	```
 - Даем нашему пользователю права на виртуальный хост
	```
 	rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
 	```
 - Включаем вебку
   	```
    	rabbitmq-plugins enable rabbitmq_management
    	```
- Проверяем что вебка стартанула и открылась.
  	```
   	ss -tunlp
	```
	- Нам нужен 15672 порт
## Порты кролика
- 15672: клиенты HTTP API и rabbitmqadmin (только если включен плагин управления).Она же вебка
- 4369: epmd, одноранговая служба обнаружения, используемая узлами RabbitMQ и инструментами CLI

- 5672, 5671: используется клиентами AMQP 0-9-1 и 1.0 без и с TLS

- 25672: используется распределением Erlang для связи между узлами и инструментами CLI и является выделено из динамического диапазона (по умолчанию ограничено одним портом, вычисляется как порт AMQP + 20000). Дополнительные сведения см. В руководстве по работе с сетью.

- 61613, 61614: STOMP клиенты без и с TLS (только если плагин STOMP включен)

- 1883, 8883: (клиенты MQTT без и с TLS, если плагин MQTT включен

- 15674: клиенты STOMP-over-WebSockets (только если плагин web STOMP включен)

- 15675: клиенты MQTT-over-WebSockets (только если включен плагин Web MQTT)
