-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM sakila.store
INNER JOIN sakila.address
	ON sakila.store.address_id = sakila.address.address_id
INNER JOIN sakila.city
	ON sakila.address.city_id = sakila.city.city_id
INNER JOIN sakila.country
	ON sakila.city.country_id = sakila.country.country_id
GROUP BY store_id
;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(amount)
FROM sakila.store
INNER JOIN sakila.inventory
	ON sakila.store.store_id = sakila.inventory.store_id
INNER JOIN sakila.rental
	ON sakila.inventory.inventory_id = sakila.rental.inventory_id
INNER JOIN sakila.payment
	ON sakila.rental.rental_id = sakila.payment.rental_id
GROUP BY store_id
;

-- 3. What is the average running time of films by category?
SELECT category_id, AVG(length)
FROM sakila.film
INNER JOIN sakila.film_category
	ON sakila.film.film_id = sakila.film_category.film_id
GROUP BY category_id
;

-- 4. Which film categories are longest?
SELECT category_id, AVG(length)
FROM sakila.film
INNER JOIN sakila.film_category
	ON sakila.film.film_id = sakila.film_category.film_id
GROUP BY category_id
ORDER BY AVG(length) DESC
LIMIT 5
;

-- 5. Display the most frequently rented movies in descending order.
SELECT film_id, title, rental_duration
FROM sakila.film
GROUP BY film_id
ORDER BY rental_duration DESC
LIMIT 5
;

-- 6. List the top five genres in gross revenue in descending order.
SELECT category_id, SUM(amount)
FROM sakila.film_category
INNER JOIN sakila.film
	ON sakila.film_category.film_id = sakila.film.film_id
INNER JOIN sakila.inventory
	ON sakila.film.film_id = sakila.inventory.film_id
INNER JOIN sakila.rental
	ON sakila.inventory.inventory_id = sakila.rental.inventory_id
INNER JOIN sakila.payment
	ON sakila.rental.rental_id = sakila.payment.rental_id
GROUP BY category_id
ORDER BY SUM(amount) DESC
LIMIT 5
;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, rental_date, return_date, store.store_id
FROM sakila.store
INNER JOIN sakila.inventory
	ON sakila.store.store_id = sakila.inventory.store_id
INNER JOIN sakila.rental
	ON sakila.inventory.inventory_id = sakila.rental.inventory_id
INNER JOIN sakila.film
	ON sakila.inventory.film_id = sakila.film.film_id
WHERE sakila.store.store_id = 1 AND sakila.film.title = "Academy Dinosaur"
ORDER BY rental_date DESC
; -- The last time it was rented was on the 23.08.2005. Since it was returned on the 30.08.2005, it is available for rent from Store 1