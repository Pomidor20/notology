# Домашнее задание к занятию 4. «PostgreSQL»

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:

- вывода списка БД,
```
\l
```
- подключения к БД,
```
\c имя_базы
```
- вывода списка таблиц,
```
\dt
```
- вывода описания содержимого таблиц,
```
\d
```
- выхода из psql.
```
\q
```
## Задача 2

Используя `psql`, создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления, и полученный результат.

```
cd /backup
curl https://raw.githubusercontent.com/netology-code/virt-homeworks/virt-11/06-db-04-postgresql/test_data/test_dump.sql
su - popstgres

psql test_database < /backup/test_dump.sq
analyze orders;


 select  avg_width from pg_stats 
 where tablename = 'orders' 
 order by avg_width  desc
 LIMIT 1
 ;
```



## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили
провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

```
BEGIN;

 create table if not exists orders_new(
 id serial,
 name varchar(50) not null,
 price int not null
 )
 PARTITION BY RANGE (price)
 ;

CREATE TABLE orders_1 PARTITION OF orders_new
    FOR VALUES FROM (MINVALUE) TO ('499');

CREATE TABLE orders_2 PARTITION OF orders_new
    FOR VALUES FROM ('499') TO (MAXVALUE);


insert into orders_new(id, name, price)
SELECT * FROM orders;

-- отвязваем внешний ключ у таблицы clients  к таблице orders,а потом перепривязываем к orders_new
-- ALTER TABLE clients DROP CONSTRAINT fk_user;
-- ALTER TABLE clients
-- ADD CONSTRAINT fk_user FOREIGN KEY (order_id) REFERENCES orders_new (id); 

drop table orders ;

COMMIT; 

```

Я так понимаю изначально надо было разбивать таблицу как описано  в транзакции выше.Или я думаю созать тригер который будет делать опредедеооные действия

## Задача 4

Используя утилиту `pg_dump`, создайте бекап БД `test_database`.
```shell
pg_dump -U postgres test_database > db.sql
```
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?  
*Можно изменить таблицу `orders`. Добавить ограничение уникальности (UNIQUE) столбцу `title`*
```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
);
```
*Или в загруженной базе изменить столбец через ALTER TABLE*
```sql
ALTER TABLE ONLY public.orders ADD CONSTRAINT orders_title_key UNIQUE (title);
```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

