# Начало
## Простые команды
Количество слоев указывается только лишь тех - которые занимают место

- 3 инструкции занимаю место в слоях - COPY RUN ADD
- Получить информацию о контейнере
  ```
  docker inspect name_container | jq # jq это вывод в json 
  ```
- Получить информацию по слоям
  ```
  docker history name_containet
  ```
- Создание системного пользователя
  ```
  RUN addgroup --system python && \
    adduser --system --disabled-password  --ingroup python python && chown python:python /app
  USER python

  ```
- Получить список процессов в докере
  ```
  pstree
  ```
- 
## Hadolint
Hadolint представляет собой утилиту (линтер), предназначенную для оценки Dockerfile с точки зрения корректности синтаксиса и безопасности инструкций. Также Hadolint проводит проверку на соблюдение лучших практик по написанию инструкций в Dockerfile.  

Пример
```
docker run --rm -i hadolint/hadolint < Dockerfile
```
После того, как анализ будет завершен, в терминале будут выведены все недочеты, которые были найдены в Dockerfile. Можно заметить, что утилита указала на то, что в нашем Dockerfile используется тег latest, в то время как необходимо указывать конкретную версию в базовом образе. Также утилита сообщила нам, что для использования портов необходимо использовать диапазон с 0 до 65535, а в нашем Dockerfile указан порт 80000. В качестве уровней предупреждения используются следующие:

info — рекомендации не являются обязательными к исправлению, но помогут оптимизировать образ;

warning — необходимо обратить внимание на недочеты, как правило, предоставляются советы из официальной документации по оптимизации Dockerfile;

error — найдены критические ошибки, которые влияют на сборку образа и могут привести к проблем после запуска контейнера.

Для идентификации ошибок Hadolint использует правила. Каждое правило имеет свой уникальный буквенно-цифровой код. Найти все правила и их описания, содержащие шаги по устранению ошибок, можно по [ссылке](https://github.com/hadolint/hadolint#rules).

Если вы не хотите запускать Hadolint в контейнере, его можно установить на [хост](https://github.com/hadolint/hadolint/blob/master/README.md#Install) или использовать [онлайн](https://hadolint.github.io/hadolint/). 
## DIVE
Программа для оаботы со слоями
Можно запустить 2 -умя вариантами 
1. dive имя_контейнера
2. docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive имя_образа

## Работаем со слоями
Через Хистори или Dive мы узнаем номер интересуещего нас слоя и дальше можем его разорхивировать и разобрать
1. Сохраняем слой
   ```
   docker image save -o /tmp/image.tar.gz имя_образа
   ```
2. Разорхивируем олученный образ
   ```
   tar xf /tmp/image.tar.gz
   ```
3. Дальше переходим в blobs/sha256 и рахорхивируем нужный слой
   ```
   cd ./blobs/sha256
    tar xf имя_слоя
   ```
4. 

## Multistage

```
FROM python:3.9-slim as builder
...
FROM python:3.9-alpine as worker
COPY --chown=python:python --from=builder /app/venv ./venv
```
## SHELL/EXEC

ENTRYPOINT ["/bin/ping", "ya.ru"]  #exec#  запускает command arg без  создания оболочки (sh, bash, zsh)   
ENTRYPOINT /bin/ping ya.ru  #shell# запускает команду в виде /bin/sh -c 'command arg';     

CMD ["/bin/ping", "ya.ru"]  #exec#  запускает command arg без  создания оболочки (sh, bash, zsh)     
CMD /bin/ping ya.ru  #shell#  запускает команду в виде /bin/sh -c 'command arg';     

#### Первая часть с EXEC
ENTRYPOINT ["/bin/ping", "ya.ru"]   
CMD ["/bin/ping", "ya.ru"]   
Правила:   
1. Если не указать CMD or ENTRYPOINT то просто вызывается последний  CMD  или ENTRYPOINT из FROM образа.
2. #CMD легко перезаписать!
```
FROM ubuntu
RUN apt update && apt install -y iputils-ping psmisc
CMD ["/bin/ping", "ya.ru"]
```
Запускам с ключем 
```
docker run --rm --name  test_entry_cmd_2 test_entry_cmd_2 ping mail.ru
```
Будет пинговаться mail.ru - так как мы переопределили cmd
3. Если докрфайл создан через ENTRYPOINT ["/bin/ping", "ya.ru"]и попытаться при запуске дописать другой сайт (или другое что то - то он попытается это подставить с правой стороны)
   ```
   FROM ubuntu
   RUN apt update && apt install -y iputils-ping psmisc
   ENTRYPOINT ["/bin/ping", "ya.ru"]
   ```
   Патаемся запустить
   ```
   docker run --rm --name  test_entry_cmd_1 test_entry_cmd_1 ls
   ```
   Получим ошибку,так как он пытается записать в таком виде ENTRYPOINT ["/bin/ping", "ya.ru", ls] - и пропинговать сайт ls
##### Вывод по первой части
CMD легко перезаписать!
```
docker run --rm --name  test_entry_cmd_1 test_entry_cmd_1 ping netology.ru
```
Перезаписать ENTRYPOINT чутка сложнее!
```
docker run --rm --name  test_entry_cmd_1 --entrypoint "ping"  test_entry_cmd_1 "stackoverflow.com"
```   
   
## Secret   
### Файл сикрета
Для работы с сикретами мы их передаем через mount файла.В контейнере оно будет лежать в `/run/secrets/`

Команда `docker build --secret` позволяет передавать секретные данные в контейнер на этапе сборки, чтобы избежать их хранения в образе. Это удобно, если вам нужно передать доступ к токенам или ключам API для скачивания приватных репозиториев или выполнения команд, требующих аутентификации, при этом не раскрывая их внутри Docker-образа.

##### Пошаговое использование `docker build --secret`

1. **Подготовьте Dockerfile.**
   В Dockerfile нужно указать, что секрет будет использован для конкретной команды. Это делается с помощью директивы `--mount=type=secret`.

   Пример Dockerfile:
   ```Dockerfile
   # Используем базовый образ
   FROM alpine
   
   # Устанавливаем необходимые пакеты
   RUN apk add --no-cache curl
   
   # Используем секрет для скачивания файла
   RUN --mount=type=secret,id=my_secret curl -H "Authorization: Bearer $(cat /run/secrets/my_secret)" https://api.example.com/private-data -o /data/private-file.txt
   ```

2. **Создайте файл с секретом.**
   Создайте файл, который будет содержать ваш секрет (например, API-токен). Пусть он называется `secret.txt`.

   Пример файла:
   ```plaintext
   my-secret-api-token
   ```

3. **Запустите сборку образа с секретом.**
   Для этого используйте флаг `--secret` и укажите путь к файлу с секретом.

   Пример команды:
   ```bash
   docker build --secret id=my_secret,src=secret.txt -t my_image .
   ```

   Здесь:
   - `id=my_secret` — идентификатор секрета, который будет использоваться в Dockerfile.
   - `src=secret.txt` — путь к локальному файлу с секретом.

4. **Проверьте результат.**
   Во время сборки секрет будет доступен внутри контейнера в `/run/secrets/my_secret`. После завершения сборки этот файл будет удален, и секрет не попадет в финальный образ.

### SSH

```
eval $(ssh-agent) && ssh-add   
docker build --ssh default=$SSH_AUTH_SOCK .   
Dockerfile:   
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan gitlab.com >> ~/.ssh/known_hosts   
RUN --mount=type=ssh \   
ssh -q -T git@gitlab.com 2>&1 | tee /hello   
---------   
export MYSECRET=qwerty   
docker build --secret id=env_sec,env=MYSECRET .   
Dockerfile:   
RUN --mount=type=secret,id=env_sec < command > $(cat /run/secrets/MYSECRET)  
```
# DOcker compose

- Переменная по умолчанию.Если на задана переменная VARIABLE,то будет выставлена default - выражение :-  
${VARIABLE:-default}

- Лимиты по ресурсам
``` yaml
  Резервы и лимиты
version: '3'
services:
db:
image: mysql
deploy:
resources:
limits:
cpus: ”0.5”
memory: 256M
reservations:
cpus: ”0.25”
memory: 128M
```
## Якоря

YAML-якоря (anchors) — это механизм для сокращения кода и повторного использования частей данных в одном и том же YAML-документе. Якоря позволяют объявить часть данных один раз и затем многократно использовать её в разных местах документа. Это удобно, когда требуется многократно повторить одни и те же значения, и в случае изменений не нужно редактировать их везде вручную.

Пример использования YAML-якорей:
```yaml

defaults: &defaults
  adapter: mysql
  host: localhost

development:
  <<: *defaults
  database: dev_db

test:
  <<: *defaults
  database: test_db
```
Разбор:
Создание якоря: В блоке defaults создается якорь &defaults, который сохраняет блок данных (в данном случае — параметры adapter и host).

Использование якоря: В блоках development и test используется ссылка на этот якорь <<: *defaults, которая вставляет в эти блоки данные из якоря defaults. Единственное различие между этими блоками — это имя базы данных, которое переопределяется для каждого блока.
```
Как это работает:   
& — создаёт якорь с именем (например, &defaults).   
* — ссылка на якорь (например, *defaults).   
<< — указывает, что данные из якоря нужно вставить в текущий блок.   
```
Пример с несколькими блоками   

```
person: &person
  name: John
  age: 30

job: &job
  title: Developer
  company: Tech Corp

full_profile:
  <<: [*person, *job]
  location: New York
```
-----   
http://wiki.rosalab.ru/ru/index.php/%D0%AD%D0%BA%D1%81%D0%BF%D0%BB%D1%83%D0%B0%D1%82%D0%B0%D1%86%D0%B8%D1%8F_Docker#:~:text=%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG,-%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG%20%D0%BF%D0%BE%D0%B7%D0%B2%D0%BE%D0%BB%D1%8F%D0%B5%D1%82&text=%D0%92%20%D0%BE%D1%82%D0%BB%D0%B8%D1%87%D0%B8%D0%B5%20%D0%BE%D1%82%20ENV%2D%D0%BF%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D1%8B%D1%85,%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B5%20%D0%B2%D0%BE%20%D0%B2%D1%80%D0%B5%D0%BC%D1%8F%20%D0%B5%D0%B3%D0%BE%20%D0%B2%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F.    

https://github.com/netology-code/virtd-homeworks/blob/shvirtd-1/05-virt-04-docker-in-practice/lecture_demonstration/09.ENTRYPOINT_CMD/1.Dockerfile    
