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
## DIVE
Программа для оаботы со слоями
Можно запустить 2 -умя вариантами 
1. dive имя_контейнера
2. docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive имя_контейнера 

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
-----   
http://wiki.rosalab.ru/ru/index.php/%D0%AD%D0%BA%D1%81%D0%BF%D0%BB%D1%83%D0%B0%D1%82%D0%B0%D1%86%D0%B8%D1%8F_Docker#:~:text=%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG,-%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%86%D0%B8%D1%8F%20ARG%20%D0%BF%D0%BE%D0%B7%D0%B2%D0%BE%D0%BB%D1%8F%D0%B5%D1%82&text=%D0%92%20%D0%BE%D1%82%D0%BB%D0%B8%D1%87%D0%B8%D0%B5%20%D0%BE%D1%82%20ENV%2D%D0%BF%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D1%8B%D1%85,%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B5%20%D0%B2%D0%BE%20%D0%B2%D1%80%D0%B5%D0%BC%D1%8F%20%D0%B5%D0%B3%D0%BE%20%D0%B2%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D1%8F.
