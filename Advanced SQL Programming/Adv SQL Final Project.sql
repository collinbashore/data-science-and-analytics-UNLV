SELECT DISTINCT name
FROM sakila.category;

DELIMITER $$
CREATE PROCEDURE sp_actor_first_name(IN actor_firstname VARCHAR(45))
BEGIN
	SELECT first_name, CONCAT(first_name, ' ' , last_name) AS actor
	FROM actor
    WHERE first_name = actor_firstname;
END $$

CALL sp_actor_first_name('Penelope');

CALL sp_actor_first_name('Collin');

Delimiter //
create procedure ActorName(IN Name VARCHAR(255))
Begin
Select *
from actor
Where first_name = Name;
END
//

CALL ActorName(‘Penelope’);

SELECT *
FROM film;

SELECT * 
FROM film_category;

SELECT *
FROM category;


