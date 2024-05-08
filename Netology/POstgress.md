После установки postgresql нужно инициализировать cluster.Ключ K подсчет контрольных сумм страниц памяти.
initdb -U postgres -K -D /путь_до_места где будут лежать все данные кластера







- Команда управления postgresql
```
psql
```
- Управление кластером Postgres.pg_ctlcluster является обеткой(скриптом) над pg_ctl.
```
pg_ctl
pg_ctlcluster
```
Пример команд:
pg_ctlcluster версия имя_кластера действие
```
pg_ctl reload(stop,start)
pg_ctlcluster 13 main stop
```


------------
## Полезные запросы

- Закрыть все соединения у БД     
SELECT pg_terminate_backend(pg_stat_activity.pid)     
FROM pg_stat_activity   
WHERE pg_stat_activity.datname = 'testbd' AND pid <> pg_backend_pid();   

- Получить список всех таблиц
  ```
  select * from pg_tables;
  ```
-----
## короткие команды PSQL
\set - вывести все переменны   
\i - выполнить команды из файла   
\o - пеерключить вывпод в файл   
\\! - выполнение команд из OS (к примеру  cat,pwd и тд)   
\gexec - Выполнить результат запроса.У примеру можно сформировать завпрос на олученеи таблицы и вполнить его не обязательно сохраняя в файл.К примеру запрос ниже сформирует получание количества строк в таблице   
      ```
      SELECT format('SELECT count(*) FROM %I;', tablename)   
      FROM pg_tables LIMIT 3   
      \gexec   
      ```

