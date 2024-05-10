После установки postgresql нужно инициализировать cluster.Ключ K подсчет контрольных сумм страниц памяти.
initdb -U postgres -K -D /путь_до_места где будут лежать все данные кластера
- При запуске psql выполняются два скрипта (при их наличии):
  - сначала общий системный скрипт psqlrc;
  - затем пользовательский файл .psqlrc.
    Пользовательский файл должен располагаться в домашнем каталоге, а расположение системного скрипта можно узнать командой:
    student$ pg_config --sysconfdir
    /etc/postgresql-common
    По умолчанию оба файла отсутствуют.

## Службы(процессы) Postgres
- autovacuum worker - служба для автоматического удаления и очестки от удаленных или отменненных данных
- walwritter - записывает журналы WAL на диск
- checkpointer - периодически сбрасывающий все грязные буферы на диск
- bgwriter - записывает только часть грязных буферов, причем те, которые с большой вероятностью будут вытеснены в ближайшее время
- stats collector - ему передается вся статистика от транзакций.

## Простые команды
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
### Важные таблицы
- Таблица pg_settings показывает текущую конфигурауию сервера.
 ```
 select * from pg_settings;
 select * from pg_settings \gx
 ```
- Таблица pg_file_settings показывает содержимое файлов конфигурации
 ```
  SELECT *  FROM   pg_file_settings ;
 ```
  или
 ```
 SELECT sourceline, name, setting, applied
 FROM pg_file_settings
 WHERE sourcefile LIKE '/etc/postgresql/13/main/postgresql.conf'
 ``` 
-  Получить весь список таблиц пердаствления
 ```
 \dv pg_catalog.*
 ```
-  
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
- Получить список всех баз.
  ```
  select * from  pg_database;
  ```
- Получить размер бд
  ```
   SELECT pg_size_pretty(pg_database_size('appdb'));
  ```
- 
- Посмотреть значение буферного кеша.
  ```
  SHOW shared_buffers;
  ```
- Посмотреть использовался ли буферный кеш и если использовался то сколько .
  ```
  EXPLAIN (analyze, buffers, costs off, timing off)
  SELECT * FROM t;
  ```
- Посмотреть текущую позицию в журнале WAL.
  ```
  SELECT pg_current_wal_lsn();
  ```
- получить размер изменения между 2 журналами в байтах
  ```
  SELECT '0/345C978'::pg_lsn - '0/3459948'::pg_lsn AS bytes;
  ```
- посмотреь файлы WAL в папке
  ```
  SELECT * FROM pg_ls_waldir() ORDER BY name;
  ```
- 
-----
###  короткие команды PSQL   
\set - вывести все переменны   
\i - выполнить команды из файла   
\o - пеерключить вывпод в файл   
\\! - выполнение команд из OS (к примеру  cat,pwd и тд)   
\echo :{?workdir} - Данная конструкция :{? } проверяет существует ли данная переменная и возвращает TRUE или FALSE.
\gexec - Выполнить результат запроса.У примеру можно сформировать завпрос на олученеи таблицы и вполнить его не обязательно сохраняя в файл.К примеру запрос ниже сформирует получание количества строк в таблице   
      ```
      SELECT format('SELECT count(*) FROM %I;', tablename)   
      FROM pg_tables LIMIT 3   
      \gexec   
      ```
-------------
 ## Файлы и папки
- pg_xact.Лежит в $PGDATA (/var/lib/postgresql/15/main/).В нем лежат файлы статусов транзакций в системе.
- PGDATA/pg_stat_tmp и PGDATA/pg_stat - тут лежат файлы статистики собранные от процесса  stats collector

-----
Рекомендации к настройке
- Буферный кеш выставлять 1/4 от размера оперативки.Изменяется в файле postgres.conf - shared_buffers=..
