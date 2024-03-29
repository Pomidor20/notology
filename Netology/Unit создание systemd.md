## Для создания простейшего юнита надо описать три секции: [Unit], [Service], [Install]

### В секции Unit описываем, что это за юнит:
>[!NOTE]
> Это первая обязательная секция. В ней описаны правила взаимодействия с другими службами и указаны метаданные — описание и документация.  Подробнее:  
> Description — описание модуля.  
> Documentation — страница руководства man.  
> After — после каких демонов и событий нужно запускать модуль. Например, модули веб-серверов запускаются только после сетевых интерфейсов.  
> Requires — сервисы, необходимые для работы юнита  
> Wants — сервисы, которые желательно запустить перед стартом модуля  

- Названия переменных достаточно говорящие:  
  
  Описание юнита:
  Description=MyUnit

### Далее следует блок переменных, которые влияют на порядок загрузки сервисов:

- Запускать юнит после какого-либо сервиса или группы сервисов (например network.target):  
  After=syslog.target  
  After=network.target  
  After=nginx.service  
  After=mysql.service  

- Для запуска сервиса необходим запущенный сервис mysql:  
  Requires=mysql.service  

- Для запуска сервиса желателен запущенный сервис redis:  
  Wants=redis.service  

>[!NOTE]
>В итоге переменная Wants получается чисто описательной.
>Если сервис есть в Requires, но нет в After, то наш сервис будет запущен параллельно с требуемым сервисом, а не после успешной загрузки требуемого сервиса

### В секции Service указываем какими командами и под каким пользователем надо запускать сервис:

#### Тип сервиса:  
 - Type=simple
   (по умолчанию): systemd предполагает, что служба будет запущена незамедлительно. Процесс при этом не должен разветвляться. Не используйте этот тип, если другие службы зависят от очередности при запуске данной службы.

 - Type=forking
   systemd предполагает, что служба запускается однократно и процесс разветвляется с завершением родительского процесса. Данный тип используется для запуска классических демонов.

 - Также следует определить PIDFile=, чтобы systemd могла отслеживать основной процесс:
   PIDFile=/work/www/myunit/shared/tmp/pids/service.pid

 - Рабочий каталог, он делается текущим перед запуском стартап команд:
   WorkingDirectory=/work/www/myunit/current

#### Пользователь и группа, под которым надо стартовать сервис:
      User=myunit
      Group=myunit


 - Переменные окружения:
   Environment=RACK_ENV=production

 - Запрет на убийство сервиса вследствие нехватки памяти и срабатывания механизма OOM:
   -1000 полный запрет (такой у sshd стоит), -100 понизим вероятность.
   OOMScoreAdjust=-100

#### Команды на старт/стоп и релоад сервиса

ExecStart=/usr/local/bin/bundle exec service -C /work/www/myunit/shared/config/service.rb --daemon
ExecStop=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state stop
ExecReload=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state restart

>[!NOTE]
>Тут есть тонкость — systemd настаивает, чтобы команда указывала на конкретный исполняемый файл. Надо указывать полный путь.

 - Таймаут в секундах, сколько ждать system отработки старт/стоп команд.
   TimeoutSec=300


- Попросим systemd автоматически рестартовать наш сервис, если он вдруг перестанет работать.
  Контроль ведется по наличию процесса из PID файла
  Restart=always


### В секции [Install] опишем, в каком уровне запуска должен стартовать сервис

- Уровень запуска:
  WantedBy=multi-user.target

  multi-user.target или runlevel3.target соответствует нашему привычному runlevel=3 «Многопользовательский режим без графики. Пользователи, как правило, входят в систему при помощи множества консолей или через сеть»

## Вот и готов простейший стартап скрипт, он же unit для systemd:
myunit.service
```
[Unit]
Description=MyUnit
After=syslog.target
After=network.target
After=nginx.service
After=mysql.service
Requires=mysql.service
Wants=redis.service

[Service]
Type=forking
PIDFile=/work/www/myunit/shared/tmp/pids/service.pid
WorkingDirectory=/work/www/myunit/current

User=myunit
Group=myunit

Environment=RACK_ENV=production

OOMScoreAdjust=-1000

ExecStart=/usr/local/bin/bundle exec service -C /work/www/myunit/shared/config/service.rb --daemon
ExecStop=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state stop
ExecReload=/usr/local/bin/bundle exec service -S /work/www/myunit/shared/tmp/pids/service.state restart
TimeoutSec=300

[Install]
WantedBy=multi-user.target 
```

-----
https://timeweb.cloud/tutorials/linux/kak-ispolzovat-systemctl-dlya-upravleniya-sluzhbami-systemd
