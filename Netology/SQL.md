## DDL (Data definition Language) - Операторы определения данных.Меняет все,кроме самих данных в таблицах
  - Create. Создать объект базы данных (база,таблица,представление,пользователя и тд)
  - Alter.Изменить объект.х (база,таблица,представление,пользователя и тд)
  - Drop.Удалить объектх (база,таблица,представление,пользователя и тд)


## DML (Монипуляция над данными).
  - SELECT.выбирает данные, удовлетворяющие заданным условиям.
  - INSERT добавляет новые данные,
  - UPDATE изменяет существующие данные,
  - DELETE удаляет данные;


## Общие команды
- Создать базу данных
```
CREATE DATABASE numbers;
CREATE DATABASE if not exists numbers;
```
- Создать таблицу.Перед создание таблицы нужно провалиться в нее исользуя USE имя_базы_данных;!!!!!!
```
create table zlooba (
number int(15) primary key AUTO_INCREMENT,
user varchar(15) not null,
male varchar(15) not null
);
```
- Наполнить таблицу данными
```
INSERT INTO	zlooba ()
VALUES (122, 'pupkin', 'male')
```
или
```
INSERT INTO	zlooba (тут список полей через запятую)
VALUES (122, 'pupkin', 'male')
```
Если много
```
INSERT INTO table1 (name,male)
values ('kolya','man'),
('fedya','man'),
('ann','woman');
```
## SELECT
### Простые выборки
- Получить что то с выборкой (**SELECT**)
```
Select имя_стобца(ов) From имя_таблицы
SELECT name FROM table1
SELECT name,date FROM table1
```
>[!Note]
>Можно к выборке добавить ко всем одно значение.SELECT name,15 FROM table1.В выводе добавит всем колонку 15 и простовит у всех в этой колонке значение 15.Можно вместо 15 добавить какое либо действие с колонкой к примеру ('аванс'*2) выведет в колонку результат аванса * 2.

### преобразование

- **CAST**.
При работе с разными типами данных часто нужно преобразовывать один тип данных к другому, для этого используется оператор CAST со следующим синтаксисом:
```
CAST(value AS type)
```
В таблице payment столбец payment_date имеет тип данных datetime, то есть дата и время, а нужно работать только с датой, для этого преобразуем datetime к date:
```
SELECT payment_id, CAST(payment_date AS DATE)
FROM payment;
CAST(value AS type)
```
>[!NOTE]
>Если не преобразовать значение к DATE, то при выборке по дате можно получить не целый день,а только его начало.К примеру если сделать выборку с 20 по 23 число,то в выборку попадет начало 23 числа (00:00:00, а не 23:59:59)
- 

### Выборки с фильтром и сортировкой
- К пример отобрать наченеи где id=8
```
SELECT name FROM table1 WHERE id = 8
SELECT name FROM table1 WHERE id in (8,15,25)
```
- **BETWEEN**. Для того чтобы найти значения в заданном диапазоне,используется оператор BETWEEN. Данный оператор можно использовать с числами, строками и датами. Крайние значения включаются в результат.
К примеру, нужно найти все платежи, стоимость которых между 5 и 7 включительно:
```
SELECT * FROM payment WHERE amount BETWEEN 5 AND 7;
```
- Краткий справочник операторов 

| Оператор | Кратко | Пример | 
| :---:  | --- | --- |
| = | Равно |`id` = 10 |
| <> | Не равно | `id` <> 10 | 
| > | Больше | `id` > 10 | 
| >= | Больше либо равно | `id` >= 10 |
|< | Меньше | `id` < 10 | 
| <= | Меньше либо равно | `id` <= 10 | 
| BETWEEN | В диапазоне между (включительно как в примере 10 и 20 включительно) | `id` BETWEEN 10 AND 20 | 
| NOT BETWEEN | Не в диапазоне между (включительно) | `id` NOT BETWEEN 10 AND 20 | 
| IN | Принадлежит списку | `id` IN (10, 11,12) | 
| NOT IN | Не принадлежит списку | `id` NOT IN (10, 11,12) | 
| LIKE | содеоржит | SELECT * FROM `workers` WHERE `role` LIKE '%ор%' |

- Шаблоны для like и не только

| Спец. символ | Кратко | Пример | результат |
| :---:  | --- | --- |--- |
| -  | Один любой символ | `name` LIKE `К_т` `name` LIKE `_от` `name` LIKE `Ко_` `name` LIKE `_о_` | Кот, Кит,Ток, Лом |
| % | Любое количество символов | `name` LIKE `К%т` | Крот, Компот | 



- Тут будет выбраны все поля,где id больше 2,отсортированы меньшего к большему по строке male, выведены первый 3 строки,далее **OFFSET** сдивитт резуьтат на 2 строчки вниз.
  ```
  select * from table1
  where 'id' > 2
  order by male
  limit 3 offset 2
  ```

- **AS**. Задает alias или "имя колонки".
  ```
  SELECT user_id AS id, username AS user FROM accounts;
  ```
  или не обязательно указывать слово AS
  ```
  SELECT customer_id, last_name Фамилия, first_name Имя FROM customer;
  SELECT f.title, c.name Имя, f.rental_rate/f.rental_duration AS cost_per_day 
  FROM film f
  JOIN film_category fc ON fc.film_id = f.film_id
  JOIN category c ON c.category_id = fc.category_id;
  ```
- **UNION**. Оператор SQL UNION используется для объединения двух и более запросов оператора SQL SELECT.Нужно выбирать одинаковое количество столбов в каждом запросе select!!!
  ```
  SELECT Singer FROM Artists
  UNION
  SELECT Album FROM Artists
  ```
### Сортировки
- **order by**.Сортировка от меньшего к большему.(по умолчанию в конце троки скрыто слово **ASK**)
  ```
  select * from table1 order by male;
  ```

-   **order by**.Сортировка от большему меньшему.Нужно в конце добавить только **DESC**
  ```
  select * from table1 order by male DESC;
  ```
-  **order by**.Сортировка от меньшего к большему и вывести только 3 строки 
  ```
  select * from table1 order by male limit 3;
  ```
- **GROUP BY**.Групирует не уникальные значения в столбце(в выводе будут только уникальные значения).Если вы хотите выбрать имя пользователя для каждого значения в столбце "male", вам нужно либо исключить столбец "name" из оператора   SELECT, либо включить его в оператор GROUP BY.Не забудь про  **HAVING**
  ```
  SELECT name, male FROM table1 GROUP BY male, name;
  ```
- **HAVING**.Использется ТОЛЬКО ПОСЛЕ GROUP BY для уточнения условий(аналог в простом запросе WHERE)

- 
### Агрегационные функции
Таблица

| Функция | Задача  |
| :---:  | --- |
| COUNT(expr) | Если в expr передан атрибут - будут подсчитаны все не-null значения Если в expr передана звездочка (COUNT(*)), то будут подсчитаны все строки в таблице | 
| MIN(expr) | Выбирает минимальное значение выражения/атрибута expr |
| MAX(expr) | Выбирает максимальное значение выражения/атрибута expr |
| AVG(expr) | Вычисляет среднее арифметическое значение выражения/атрибута expr |
| SUM(expr) | Вычисляет сумму значений выражения/атрибута expr |
| (expr) | Это столбец или вычисляемое значение с помощью таблицы | 

Пример использования 
```
SELECT MAX('AGE') FROM users
````

## JOIN

### INNER JOIN
Если использовать оператор INNER JOIN, в результат запроса попадут только те записи, для которых выполняется условие объединения. Еще одно условие — записи должны быть в обеих таблицах. Каждая строка из первой (левой) таблицы, сопоставляется с каждой строкой из второй (правой) таблицы, после чего происходит проверка условия. Если условие истинно, то строки попадают в результирующую таблицу. В результирующей таблице строки формируются конкатенацией строк первой и второй таблиц.
Общий синтаксис запроса INNER JOIN:

```
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```
http://2sql.ru/novosti/sql-inner-join/

### LEFT JOIN
LEFT JOIN - это операция объединения, которая возвращает все строки из левой таблицы table1 и только соответствующие строки из правой таблицы table2. Если в правой таблице нет соответствующей строки, то возвращается NULL для значений правой таблицы.И если в правой таблице есть знаяиния которых нет в левой - ОНИ  ОТБРАСЫВАЮТСЯ.
```
SELECT *
FROM table1
LEFT JOIN table2
ON table1.key_column = table2.key_column;
```
http://2sql.ru/novosti/sql-left-join/

## Индексы
Индексы помогают и ускоряют запросы SQL.
### MYSQL
```
CREATE INDEX id_index ON table_name(column_name);
ALTER TABLE t2 ADD INDEX (d);
```

### EXPLAIN
Эта команда помогает определить узкое место в запросе.Эта команда примерно оценивает выполнение..EXPLAIN работает с SELECT, DELETE, INSERT, REPLACE и UPDATE операторами. В MySQL 8.0.19 и более поздних версиях он также работает с оператором TABLE. Оператор EXPLAIN выводит план запроса.
Имеет 3 варианта запуска.ДЛя измененрия запуска после explain пишут format = тут тип из списка ниже  :
- TRADITIONAL — вывод в табличном формате;
- JSON — вывод в формате JSON;
- TREE — древовидный вывод с более точными описаниями обработки запросов, чем TRADITIONAL.
```
explain #format = tree #traditional
SELECT s.store_id ,
         c.city,
         concat(s2.first_name,' ',s2.last_name),
         count(c2.customer_id)
         ......
```
Чтение данных из таблицы может выполняться несколькими способами. В нашем случае EXPLAIN сообщает, что используется Seq Scan — последовательное, блок за блоком, чтение данных таблицы foo.
Что такое cost? Это не время, а некое сферическое в вакууме понятие, призванное оценить затратность операции. Первое значение 0.00 — затраты на получение первой строки. Второе — 18334.00 — затраты на получение всех строк.
rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan. Это значение возвращает планировщик. В моём случае оно совпадает с реальным количеством строк в таблице.
width — средний размер одной строки в байтах.

### EXPLAIN ANALYZE
Эта команда в отличии о преведущей - реально прогоняет код и выводит оценочный результат

В выводе команды информации добавилось.
actual time — реальное время в миллисекундах, затраченное для получения первой строки и всех строк соответственно.
rows — реальное количество строк, полученных при Seq Scan.
loops — сколько раз пришлось выполнить операцию Seq Scan.
Total runtime — общее время выполнения запроса.

### Что бы увидеть какие запросы выполняются медленно открываем файл и вносим измененрия (в примере ниже мы используем MYSQL)
После изменения файла конфигурации нужно рестартануть службу MYSQL.
```
	
sudo nano /etc/mysql/my.cnf
slow-query-log      = 1
slow-query-log-file = /var/log/mysql/mysql-slow.log
long_query_time     = 3
/etc/init.d/mysql restart
```
 - slow-query-log - ключем логирование медленных запросов
 - slow-query-log-file - указываем в какой фаил писать лог
 - long_query_time  - Тут указываем после какого колическва секунд запрос будет считаться медленным.




## MYSQL
- SHOW.Командля для просмотра чего либо.
  ```
  show databases;
  ```
- USE.Выбрать конкретную DB
  ```
  USE test;
  ```
- 
