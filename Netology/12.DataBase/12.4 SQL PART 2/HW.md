# Домашнее задание к занятию «SQL. Часть 2»

### Инструкция по выполнению домашнего задания

1. Сделайте fork [репозитория c шаблоном решения](https://github.com/netology-code/sys-pattern-homework) к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/gitlab-hw или https://github.com/имя-вашего-репозитория/8-03-hw).
2. Выполните клонирование этого репозитория к себе на ПК с помощью команды `git clone`.
3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
   - впишите вверху название занятия и ваши фамилию и имя;
   - в каждом задании добавьте решение в требуемом виде: текст/код/скриншоты/ссылка;
   - для корректного добавления скриншотов воспользуйтесь инструкцией [«Как вставить скриншот в шаблон с решением»](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md);
   - при оформлении используйте возможности языка разметки md. Коротко об этом можно посмотреть в [инструкции по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md).
4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`).
5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
6. Любые вопросы задавайте в чате учебной группы и/или в разделе «Вопросы по заданию» в личном кабинете.

Желаем успехов в выполнении домашнего задания.

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

### Ответ 1
```
select store.store_id, concat(staff.first_name,' ', staff.last_name), city.city, count(customer.customer_id) 
from store
left join address on store.store_id = address.address_id 
right join staff on store.manager_staff_id = staff.staff_id
left join city on address.city_id = city.city_id 
right join customer on  store.store_id = customer.store_id
group by store.store_id 
having count(customer.customer_id) > 300
;
```

### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

### Ответ 2
```
select count(*)  from film 
where lENGTH > (SELECT avg(LENGTH) FROM sakila.film);
;
```

### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

### Ответ 3
```
 SELECT DATE_FORMAT(p.payment_date, '%d.%m.%y') AS "Дата аренды", 
         count(r.rental_id) AS "Количество аренд"
    FROM payment p 
    JOIN rental r ON r.rental_id = p.rental_id 
GROUP BY DATE_FORMAT(p.payment_date, '%d.%m.%y')
ORDER BY sum(p.amount) DESC LIMIT 1;
```

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

### Ответ 4
```
-- Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

SELECT  
 staff_id,
 count(*) cnt,
 CASE
    WHEN  count(*) > 8000 THEN 'yes'
	ELSE 'nor'
	END AS premia
FROM sakila.rental
group by staff_id
HAVING cnt > 8000;
```
### Задание 5*

Найдите фильмы, которые ни разу не брали в аренду.

### Ответ 5
```
SELECT f.title AS "Название фильма",
         f.rating AS "Рейтинг",
         c2.name AS "Жанр",
         f.release_year AS "Год выпуска",
         l.name AS "Язык", 
         count(r.rental_id) AS "Количество аренд",
         sum(p.amount) AS "Общая стоимость аренды"
    FROM film f
         LEFT JOIN inventory i ON i.film_id = f.film_id 
         LEFT JOIN rental r ON r.inventory_id = i.inventory_id
         LEFT JOIN customer c ON c.customer_id = r.inventory_id
         LEFT JOIN payment p ON p.rental_id = r.rental_id
         INNER JOIN film_category fc ON fc.film_id = f.film_id 
         INNER JOIN category c2 ON c2.category_id = fc.category_id 
         INNER JOIN "language" l ON l.language_id = f.language_id 
GROUP BY f.film_id, c2.category_id, l.language_id
HAVING count(r.rental_id) = 0 
ORDER BY f.title
```
