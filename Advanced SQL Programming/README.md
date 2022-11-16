# Course #4: Advanced SQL Programming

## **Project:** Managing Database Schema for Sequel Premiere Films

### Installation Instructions
- This project uses the Sakila database and was uploaded using MySQL workbench. Installation instructions for loading the Sakila database on MySQL Workbench is linked here: <u>[Sakila Database Installation Instructions](https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Advanced%20SQL%20Programming/8.3.2%20-%20Supplement%20-%20Sakila%20database%20Installation%20Instructions.pdf)
</u>
* The sample Sakila database can be found here: <u>[Sample Sakila Database](https://dev.mysql.com/doc/index-other.html)</u>

### **Objectives:**
- Created a schema for Sequel Premiere Films that highlights the relationships between the tables
- Normalized the given section of the table into 3NF form
- Created a stored procedure where users can input the first name and return a list of all the actors who share that first name

### Schema
<p align = "center">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Advanced%20SQL%20Programming/Sakila%20schema.PNG">
</p>

#### Notes about the schema above:
  * FILM_ACTOR and FILM_CATEGORY tables serve as **bridge** tables (or **junction** tables)
  * The relationships between the tables above are **one-to-many** relationships

### Normalization
* The following table is used for Normalization

<p align = "center">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Advanced%20SQL%20Programming/Film%20table.drawio.png">
</p>

* Below is the SQL query used to create the table above
```
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
```



* This table above is then normalized to 3NF form

<p align = "center">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Advanced%20SQL%20Programming/Normalized%20tables.PNG">
</p>

### Stored procedure
The stored procedure created allows users to input the first name and return the list of all the actors that share that first name. The name "Penelope" was used to test the stored procedure.

* Here's the SQL query used to create this stored procedure

```
DELIMITER $$
CREATE PROCEDURE sp_actor_first_name(IN actor_firstname VARCHAR(45))
BEGIN
	SELECT first_name, CONCAT(first_name, ' ' , last_name) AS actor
	FROM actor
    WHERE first_name = actor_firstname;
END $$
```



* Below is the SQL query and the output of the stored procedure.
```
CALL sp_actor_first_name('Penelope');
```
<p align = "center">
<img src = "https://github.com/collinbashore/data-science-and-analytics-portfolio/blob/main/Advanced%20SQL%20Programming/Stored%20procedure%20output.drawio.png">
</p>
