-- 1. Query actor information whose first_name is 'PENELOPE'
EXPLAIN ANALYZE SELECT * FROM actor WHERE first_name = 'PENELOPE';

-- 2. Query actor information whose last_name starts with 'W'
EXPLAIN ANALYZE SELECT * FROM actor WHERE last_name LIKE 'W%';

-- 3. Query the country information whose country starts with 'A'
EXPLAIN ANALYZE SELECT * FROM country WHERE country LIKE 'A%';

-- 4. Query the number of cities in each country
EXPLAIN ANALYZE SELECT c.country, count(*)
FROM country c
JOIN city ci ON c.country_id = ci.country_id
GROUP BY c.country;

-- 5. Query the names of customers whose last_name starts with 'S' and their corresponding country information, and the country starts with 'A'
EXPLAIN ANALYZE SELECT cu.first_name, cu.last_name, co.country
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE cu.last_name LIKE 'S%' AND co.country LIKE 'A%';

-- 6. Query the number of addresses in each city
EXPLAIN ANALYZE SELECT ci.city, count(*)
FROM city ci
JOIN address a ON ci.city_id = a.city_id
GROUP BY ci.city;

-- 7. Query the number of addresses in each country and city
EXPLAIN ANALYZE SELECT co.country, ci.city, count(*)
FROM country co
JOIN city ci ON co.country_id = ci.country_id
JOIN address a ON ci.city_id = a.city_id
GROUP BY co.country, ci.city;

-- 8. Query the number of customers in each store
EXPLAIN ANALYZE SELECT s.store_id, count(*)
FROM store s
JOIN customer c ON s.store_id = c.store_id
GROUP BY s.store_id;

-- 9. Query the names of customers whose email ends with '.org' and their corresponding store information
EXPLAIN ANALYZE SELECT c.first_name, c.last_name, s.store_id
FROM customer c
JOIN store s ON c.store_id = s.store_id
WHERE c.email LIKE '%.org';

-- 10. Query the names of categories and the number of stores that have customers in each category
EXPLAIN ANALYZE SELECT cat.name, count(DISTINCT s.store_id)
FROM category cat
JOIN customer cu ON cat.last_update = cu.last_update
JOIN store s ON cu.store_id = s.store_id
GROUP BY cat.name;