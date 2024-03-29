-- 1. Query actor information whose first_name is 'PENELOPE'
EXPLAIN SELECT * FROM actor WHERE first_name = 'PENELOPE';

-- 2. Query actor information whose last_name starts with 'W'  
EXPLAIN SELECT * FROM actor WHERE last_name LIKE 'W%';

-- 3. Query the country information whose country starts with 'A'
EXPLAIN SELECT * FROM country WHERE country LIKE 'A%';

-- 4. Query the number of cities in each country
EXPLAIN SELECT c.country, count(*) 
FROM country c 
JOIN city ci ON c.country_id = ci.country_id
GROUP BY c.country;

-- 5. Query the names of actors whose last_name starts with 'W' and their corresponding country information, and the country starts with 'A'
EXPLAIN SELECT a.first_name, a.last_name, c.country
FROM actor a
JOIN address ad ON a.last_update = ad.last_update
JOIN city ci ON ad.city_id = ci.city_id  
JOIN country c ON ci.country_id = c.country_id
WHERE a.last_name LIKE 'W%' AND c.country LIKE 'A%';

-- 6. Query the number of addresses in each city
EXPLAIN SELECT ci.city, count(*)
FROM city ci
JOIN address a ON ci.city_id = a.city_id
GROUP BY ci.city;

-- 7. Query the number of addresses in each country and city
EXPLAIN SELECT c.country, ci.city, count(*)
FROM country c
JOIN city ci ON c.country_id = ci.country_id  
JOIN address a ON ci.city_id = a.city_id
GROUP BY c.country, ci.city;