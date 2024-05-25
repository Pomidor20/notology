SELECT f.title, CONCAT(a.last_name, ' ', a.first_name) AS actor_name
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id;

-- select distinct CONCAT(s.last_name, ' ', s.first_name) AS Заведующий_прокатом, CONCAT(c.last_name, ' ', c.first_name) AS Заказчик
-- FROM staff s 
-- INNER JOIN payment p ON s.staff_id  = p.staff_id
-- INNER JOIN customer c  ON c.customer_id  = p.customer_id;

SELECT CONCAT(c.last_name, ' ', c.first_name), c2.city
FROM customer c
LEFT JOIN address a ON a.address_id = c.address_id
LEFT JOIN city c2 ON c2.city_id = a.city_id;

SELECT CONCAT(c.last_name, ' ', c.first_name), c2.city
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city c2 ON c2.city_id = a.city_id;

SELECT f.title, r.rental_date 
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id is NULL;

SELECT CONCAT(c.last_name, ' ', c.first_name), c2.city
FROM customer c
RIGHT JOIN address a ON a.address_id = c.address_id
RIGHT JOIN city c2 ON c2.city_id = a.city_id
WHERE CONCAT(c.last_name, ' ', c.first_name) is NULL;

SELECT r.rental_id, r.rental_date, p.payment_id, p.payment_date, p.amount 
FROM rental r
FULL JOIN payment p ON p.rental_id = r.rental_id;

SELECT c.name, fc.category_id
FROM category c 
Cross JOIN film_category fc  ON fc.category_id  = c.category_id;

select customer_id, first_name
from customer c 
union all
select staff_id, first_name
from staff s 

-- Агрегатные функции

SELECT COUNT(1)
FROM film 
WHERE LOWER(LEFT(title, 1)) = 'a';

SELECT *
FROM film 

SELECT customer_id, COUNT(payment_id), SUM(amount), AVG(amount), MIN(amount), MAX(amount)
FROM payment
GROUP BY customer_id;

SELECT customer_id, MONTH(payment_date), COUNT(payment_id), SUM(amount)
FROM payment
GROUP BY customer_id, MONTH(payment_date);

SELECT f.title, f.release_year, f.length, COUNT(fa.actor_id)
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
-- where f.length > 48
GROUP BY f.film_id
-- having COUNT(fa.actor_id) > 4;

SELECT CONCAT(c.last_name, ' ', c.first_name), COUNT(r.rental_id)
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
having COUNT(r.rental_id) > 40;

SELECT 
	MONTH(payment_date), 
	COUNT(payment_id) / 
	(SELECT COUNT(1) FROM payment) * 100
FROM payment 
GROUP BY MONTH(payment_date);

SELECT COUNT(1) FROM payment

SELECT f.title, c.name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON c.category_id = fc.category_id
WHERE c.category_id IN 
	(SELECT category_id
	FROM category 
	WHERE name LIKE 'C%') 
ORDER BY f.title;

SELECT category_id, name
	FROM category 
	WHERE name LIKE 'C%'

SELECT CONCAT(s.last_name, ' ', s.first_name), cp / cr
FROM staff s
JOIN 
(SELECT staff_id, COUNT(payment_id) AS cp
FROM payment 
GROUP BY staff_id) t1 ON s.staff_id = t1.staff_id
JOIN 
(SELECT staff_id, COUNT(rental_id) AS cr
FROM rental 
GROUP BY staff_id) t2 ON s.staff_id = t2.staff_id;

SELECT staff_id, COUNT(payment_id) AS cp
FROM payment 
GROUP BY staff_id

SELECT staff_id, COUNT(rental_id) AS cr
FROM rental 
GROUP BY staff_id

SELECT customer_id, SUM(amount),
case
	WHEN SUM(amount) > 200 THEN 'Good user'
	WHEN SUM(amount) < 200 THEN 'Bad user'
	ELSE 'Average user'END AS good_or_bad
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) desc
LIMIT 10;

SELECT CONCAT(c.last_name, ' ', c.first_name) AS user, IFNULL(SUM(p.amount), 0)
FROM customer c
LEFT JOIN (SELECT *FROM payment 
			WHERE DATE(payment_date) = '2005-06-18') p
			ON p.customer_id = c.customer_id
GROUP BY c.customer_id

SELECT rental_id, 
	COALESCE(
	DATEDIFF(return_date, rental_date), 
	DATEDIFF(NOW(), return_date),
	DATEDIFF(NOW(), rental_date)
	) AS diff
FROM rental

