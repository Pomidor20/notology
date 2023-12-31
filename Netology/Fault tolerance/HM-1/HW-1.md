# Домашнее задание к занятию 1 «Disaster recovery и Keepalived»

### Цель задания
В результате выполнения этого задания вы научитесь:
1. Настраивать отслеживание интерфейса для протокола HSRP;
2. Настраивать сервис Keepalived для использования плавающего IP

------

### Чеклист готовности к домашнему заданию

1. Установлена программа Cisco Packet Tracer
2. Установлена операционная система Ubuntu на виртуальную машину и имеется доступ к терминалу
3. Сделан клон этой виртуальной машины, они находятся в одной подсети и имеют разные IP адреса
4. Просмотрены конфигурационные файлы, рассматриваемые на лекции, которые находятся по [ссылке](1/)

------


### Задание 1
<details>
  <summary>Задание</summary>  
- Дана [схема](1/hsrp_advanced.pkt) для Cisco Packet Tracer, рассматриваемая в лекции.
- На данной схеме уже настроено отслеживание интерфейсов маршрутизаторов Gi0/1 (для нулевой группы)
- Необходимо аналогично настроить отслеживание состояния интерфейсов Gi0/0 (для первой группы).
- Для проверки корректности настройки, разорвите один из кабелей между одним из маршрутизаторов и Switch0 и запустите ping между PC0 и Server0.
- На проверку отправьте получившуюся схему в формате pkt и скриншот, где виден процесс настройки маршрутизатора.
 </details>
 
 ### Решение 1
 
 - Конфигурим роутеры R0 и R1.Меняем приоритеты и ставим остлеживание порта.
	```
	R0
	interface GigabitEthernet0/1
	standby 1 priority 100
	standby 1 preempt
	standby 1 track GigabitEthernet0/0

	R1
	interface GigabitEthernet0/1
	standby 1 priority 110
	standby 1 preempt
	standby 1 track GigabitEthernet0/0
	```
   Режим работы двух зон на R0
   ```
    Router0#sh standby 
	GigabitEthernet0/0 - Group 0 (version 2)
	State is Active
    14 state changes, last state change 00:07:52
	Virtual IP address is 192.168.0.1
	Active virtual MAC address is 0000.0C9F.F000
    Local virtual MAC address is 0000.0C9F.F000 (v2 default)
	Hello time 3 sec, hold time 10 sec
    Next hello sent in 0.102 secs
	Preemption enabled
	Active router is local
	Standby router is 192.168.0.3, priority 100 (expires in 7 sec)
	Priority 105 (configured 105)
    Track interface GigabitEthernet0/1 state Up decrement 10
	Group name is hsrp-Gig0/0-0 (default)
	GigabitEthernet0/1 - Group 1 (version 2)
	State is Standby
    15 state changes, last state change 00:08:30
	Virtual IP address is 192.168.1.1
	Active virtual MAC address is 0000.0C9F.F001
    Local virtual MAC address is 0000.0C9F.F001 (v2 default)
	Hello time 3 sec, hold time 10 sec
    Next hello sent in 2.159 secs
	Preemption enabled
	Active router is 192.168.1.3
	Standby router is local
	Priority 100 (default 100)
	Track interface GigabitEthernet0/0 state Up decrement 10
	Group name is hsrp-Gig0/1-1 (default)
   ```
- Отключаем порт идущий к RO на SW0.   
  Видимо что R1 меняет статус со Standby на Active в группе доступности 0.
  ![1](https://github.com/Pomidor20/notology/blob/15c945e85b6fc1dd3c33a93a97420ea6559f0ebe/Netology/Fault%20tolerance/HM-1/pic/1.JPG)  
  ![1.1](https://github.com/Pomidor20/notology/blob/15c945e85b6fc1dd3c33a93a97420ea6559f0ebe/Netology/Fault%20tolerance/HM-1/pic/1.1.JPG)  
  [файл c моим СPK](https://github.com/Pomidor20/notology/blob/bc2e58621c5cbd15ffc9c8e7d71057c56d97f3de/Netology/Fault%20tolerance/HM-1/files/hsrp-advanced.pkt)  

------


### Задание 2

<details>
  <summary>Текст задания</summary>

 - Запустите две виртуальные машины Linux, установите и настройте сервис Keepalived как в лекции, используя пример конфигурационного [файла](1/keepalived-simple.conf).
 - Настройте любой веб-сервер (например, nginx или simple python server) на двух виртуальных машинах
 - Напишите Bash-скрипт, который будет проверять доступность порта данного веб-сервера и существование файла index.html в root-директории данного веб-сервера.
 - Настройте Keepalived так, чтобы он запускал данный скрипт каждые 3 секунды и переносил виртуальный IP на другой сервер, если bash-скрипт завершался с кодом, отличным от нуля (то есть порт веб-сервера был недоступен или отсутствовал index.html). Используйте для этого секцию vrrp_script
 - На проверку отправьте получившейся bash-скрипт и конфигурационный файл keepalived, а также скриншот с демонстрацией переезда плавающего ip на другой сервер в случае недоступности порта или файла index.html
 </details>

### Решенеи 2

![2](https://github.com/Pomidor20/notology/blob/main/Netology/Fault%20tolerance/HM-1/pic/2.JPG)  
![2](https://github.com/Pomidor20/notology/blob/main/Netology/Fault%20tolerance/HM-1/pic/2.1.JPG)  
[Файлы конфигураций лежат тут](https://github.com/Pomidor20/notology/tree/main/Netology/Fault%20tolerance/HM-1/files)
------

## Дополнительные задания со звёздочкой*

Эти задания дополнительные. Их можно не выполнять. На зачёт это не повлияет. Вы можете их выполнить, если хотите глубже разобраться в материале.
 
### Задание 3*
<details>
  <summary>Задание</summary>  
- Изучите дополнительно возможность Keepalived, которая называется vrrp_track_file
- Напишите bash-скрипт, который будет менять приоритет внутри файла в зависимости от нагрузки на виртуальную машину (можно разместить данный скрипт в cron и запускать каждую минуту). Рассчитывать приоритет можно, например, на основании Load average.
- Настройте Keepalived на отслеживание данного файла.
- Нагрузите одну из виртуальных машин, которая находится в состоянии MASTER и имеет активный виртуальный IP и проверьте, чтобы через некоторое время она перешла в состояние SLAVE из-за высокой нагрузки и виртуальный IP переехал на другой, менее нагруженный сервер.
- Попробуйте выполнить настройку keepalived на третьем сервере и скорректировать при необходимости формулу так, чтобы плавающий ip адрес всегда был прикреплен к серверу, имеющему наименьшую нагрузку.
- На проверку отправьте получившийся bash-скрипт и конфигурационный файл keepalived, а также скриншоты логов keepalived с серверов при разных нагрузках
 </details>
