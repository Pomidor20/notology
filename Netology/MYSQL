# MYSQL

## Пользователь и права
Создать пользователя и дать все права к базе данных.
```
create user 'sys_temp' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON * . * TO 'sys_temp';   
FLUSH PRIVILEGES;
```
>[!NOTE] GRANT type_of_permission ON database_name.table_name TO 'username'@'localhost';   
>ALL PRIVILEGES — как мы уже увидели ранее, данный набор прав предоставляет пользователю MySQL полный доступ к определенной базе данных (если не выбрана ни одна база данных, предоставляется глобальный доступ к системе)   
>CREATE — позволяет пользователю создавать новые таблицы или базы данных   
>DROP — позволяет пользователю удалять таблицы или базы данных      
>DELETE — позволяет пользователю удалять строки из таблиц   
>INSERT — позволяет пользователю вставлять строки в таблицы   
>SELECT — позволяет пользователю выполнять команду SELECT для чтения данных из базы   
>UPDATE — позволяет пользователю обновлять строки таблицы   
>GRANT OPTION — позволяет пользователю предоставлять или отзывать права других пользователей   


 - Посмотреть всех пользователей.Переключаемся на базу mysql.И выполняем запрос.
```
use mysql;
select user from user;
```

 - Посмотреть доступы конкретного пользователя 
```
SHOW GRANTS FOR 'username'@'localhost';
show grants for 'sys_temp';
```

 - Удалить пользователя.
 ```
 drop user 'sys_temp'
 ```

 - Забрать у пользователя права на вставку,удаление,обновление таблиц.
 
 ```
 REVOKE INSERT, UPDATE, DELETE ON *.* FROM 'sys_temp'@'host';
 ```
 
 
 ## Работа с БД
 
 - Импортировать из файла .sql
 
 ```
 mysql> SOURCE C:/temp/sakila-db/sakila-schema.sql;
 mysql> SOURCE C:/temp/sakila-db/sakila-data.sql;
 ```

- Получить схему таблицы
 DESCRIBE table_name; где "table_name" - название таблицы.
 ```
 DESCRIBE actor;
 ```

--------

## Полезные запросы

 - Получить все первичные ключи из бд данных.
```
SELECT TABLE_NAME, COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'sakila';
```

- Получить схему таблицы
 DESCRIBE table_name; где "table_name" - название таблицы.
 ```
 DESCRIBE actor;
 ```
