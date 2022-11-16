-- This stored procedure allows the user to input the first name and return the list of all the actors that share that same first name.

DELIMITER $$
CREATE PROCEDURE sp_actor_first_name(IN actor_firstname VARCHAR(45))
BEGIN
	SELECT first_name, CONCAT(first_name, ' ' , last_name) AS actor
	FROM actor
        WHERE first_name = actor_firstname;
END $$

CALL sp_actor_first_name('Penelope');

CALL sp_actor_first_name('Collin');
