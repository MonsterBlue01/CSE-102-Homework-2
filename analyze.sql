EXPLAIN SELECT * FROM actor WHERE first_name = 'PENELOPE';

EXPLAIN SELECT * FROM actor WHERE last_name LIKE 'W%';

EXPLAIN SELECT * FROM country WHERE country LIKE 'A%';

EXPLAIN SELECT c.country, count(*)
FROM country c
JOIN city ci ON c.country_id = ci.country_id
GROUP BY c.country;

EXPLAIN SELECT a.first_name, a.last_name, c.country
FROM actor a
JOIN city ci ON a.last_update = ci.last_update
JOIN country c ON ci.country_id = c.country_id
WHERE a.last_name LIKE 'W%' AND c.country LIKE 'A%';