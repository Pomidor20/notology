SELECT * 
FROM customer;

SELECT customer_id, last_name Фамилия, first_name Имя FROM customer;

SELECT f.title, c.name Имя, f.rental_rate/f.rental_duration AS cost_per_day 
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id;

SELECT title, rental_rate/rental_duration AS cost_per_day 
FROM film
ORDER BY cost_per_day DESC, title ASC;

SELECT title, rental_rate/rental_duration AS cost_per_day 
FROM film
ORDER BY cost_per_day DESC, title
LIMIT 10
OFFSET 5;

SELECT DISTINCT store_id, last_name, first_name
FROM customer;

SELECT *
FROM payment
WHERE amount > 7 AND staff_id = 2 OR amount < 5 AND staff_id = 1
ORDER by amount;

SELECT payment_id, payment_date, CAST(payment_date AS DATE)
FROM payment;

SELECT ROUND(100.576); -- 101
SELECT ROUND(100.576, 2); -- 100.58
SELECT TRUNCATE(100.576, 2); -- 100.57
SELECT FLOOR(100.576); -- 100
SELECT CEIL(100.576); -- 101
SELECT ABS(-100.576); -- 100.576

SELECT title, ROUND(rental_rate/rental_duration, 2) AS cost_per_day 
FROM film
ORDER BY cost_per_day DESC, title;

SELECT POWER(2, 3); -- 8
SELECT SQRT(64); -- 8
SELECT 64 DIV 6; -- 10
SELECT 64%6; -- 4
SELECT GREATEST(17, 5, 18, 21, 16); -- 21
SELECT LEAST(17, 5, 18, 21, 16); -- 5
SELECT RAND(); -- 0.005757967015502944

SELECT  rental_rate, rental_duration,
        rental_rate + rental_duration a,
        rental_rate - rental_duration b,
        rental_rate * rental_duration c,
        rental_rate / rental_duration d,
        rental_rate % rental_duration e,
        rental_rate DIV rental_duration f,
        POWER(rental_rate, rental_duration) g,
        COS(rental_rate) h, SIN(rental_duration) j
FROM film;

SELECT CONCAT(last_name, ' ', first_name, ' ', email) FROM customer;
SELECT last_name, first_name, email FROM customer;

SELECT CONCAT_WS(' ', last_name, first_name, email) FROM customer;

SELECT  LENGTH(last_name), CHAR_LENGTH(last_name), 
        LENGTH('Привет'), CHAR_LENGTH('Привет') 
FROM customer;

SELECT last_name, POSITION('D' IN last_name), SUBSTR(last_name, 2, 3), 
        LEFT(last_name, 3), RIGHT(last_name, 3) 
FROM customer;

SELECT  upper('ssss'), LOWER(last_name), INSERT(last_name, 1, 5, 'MAX'), 
        LOWER(REPLACE(last_name, 'A', 'X'))
FROM customer;

SELECT  last_name, INSERT(last_name, 2, 1, 'MAX')   
FROM customer;

SELECT CONCAT(last_name, ' ', first_name)
FROM customer 
WHERE first_name LIKE '%jam%';

SELECT DATE_ADD(NOW(), INTERVAL 3 DAY);

SELECT DATE_SUB(CURDATE(), INTERVAL 3 DAY);

SELECT YEAR(NOW()), MONTH(NOW()), WEEK(NOW()), DAY(NOW());

SELECT EXTRACT(HOUR FROM NOW()), EXTRACT(DAY_MINUTE FROM NOW()), 
    EXTRACT(DAY FROM NOW());

SELECT DATEDIFF(return_date, rental_date), QUARTER(return_date) FROM rental;

SELECT DATE_FORMAT(payment_date, '%D – %M – %Y'), TIME_FORMAT(TIME(payment_date), '%r') FROM payment;

SELECT * FROM payment WHERE amount BETWEEN 5 AND 7;









