-- Small portion of the table used for Normalization
SELECT f.film_id AS ID, 
	   f.title AS Title, 
       f.length AS Length, 
       c.name AS Genre,
       f.rating AS Rating,
       f.special_features AS Features
FROM sakila.film AS f
LEFT JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category AS c
ON fc.category_id = c.category_id
LIMIT 8;

-- This stored procedure allows the user to input the first name and return the list of all the actors that share that same first name.
DELIMITER $$
CREATE PROCEDURE sp_actor_first_name(IN actor_firstname VARCHAR(45))
BEGIN
	SELECT first_name, CONCAT(first_name, ' ' , last_name) AS actor
	FROM actor
        WHERE first_name = actor_firstname;
END $$

-- Tested the above stored procedure using the name 'Penelope'
CALL sp_actor_first_name('Penelope');
