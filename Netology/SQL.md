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
- Получить что то с выборкой (SELECT)
```
Select имя_стобца(ов) From имя_таблицы
SELECT name FROM table1
SELECT name,date FROM table1
```
>[!Note]
>Можно к выборке добавить ко всем одно значение.SELECT name,15 FROM table1.Вы выоде добавит всем колонку 15простовит у всех в этой колонке 15
- 

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
