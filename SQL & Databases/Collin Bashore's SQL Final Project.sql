###################### Collin Bashore's SQL Final Project ######################

######## Part 1: Writing Basic SQL Queires 

-- Task 1: Write a query that shows bands & their respective albums' release date in descending order.
SELECT b.bandname, a.albumname, a.releasedate 
FROM band.band AS b
RIGHT JOIN band.album AS a
ON  b.idband = a.idband
ORDER BY releasedate DESC;

-- Task 2: 
/* Write a query that shows all of the players that utilize drums along with the bands they are a part of. 
Hint: Only list one column that shows the full player name. */

SELECT CONCAT(pfname, ' ', plname) AS playername, b.bandname  
FROM band.player AS p
INNER JOIN band.band AS b
ON p.idband = b.idband
WHERE InstID = 4; -- InstID = 4 for Drums

-- Task 3: Write a query that describes the number of instruments used by each band. (Hint: Some bands may have multiple players using the same instrument)

/* Use the InstID, idplayer, and idband from the player table */

SELECT b.bandname, i.instrument, COUNT(p.InstID) AS num_of_instruments 
FROM band.band AS b
LEFT JOIN band.player AS p
ON b.idband = p.idband
LEFT JOIN band.instrument AS i
ON p.InstID = i.InstID
GROUP BY b.bandname, i.instrument;

-- Task 4: Write a query that lists the most popular instrument amongst the players. 

/* Use the InstID and idplayer columns from player */

SELECT i.instrument, COUNT(p.idplayer) AS num_of_players 
FROM band.player AS p
INNER JOIN band.instrument AS i
ON i.InstID = p.InstID
GROUP BY i.instrument
ORDER BY i.instrument DESC; -- The most popular instrument amongst all player is Vocals.

-- Task 5: Write a query that lists any albums that have a missing name and/or missing release dates. How should we handle these?
/* Use the idalbum, albumname and releasedate columns from album table. Use the IS NULL to find missing values*/

SELECT idalbum, albumname, releasedate FROM band.album
WHERE albumname IS NULL 
OR releasedate IS NULL;


######## Part 2: Joining Data, using aggregate SQL functions, inserting, updating, and deleting data 

-- Task 1: Add more bands to the band table
## Band name
# Weezer
# TLC
# Paramore
# Blackpink
# Vampire Weekend

INSERT INTO band.band (bandname)
VALUES ('Weezer'),
	   ('TLC'),
       ('Paramore'),
       ('Blackpink'),
       ('Vampire Weekend');


-- Task 2: Which table would we use to add the names of band members?

/* Use the player table to add the names of band members */


-- Task 3: Using the table identified in Task 2, add the following values (table values provided in 2.8 final project.pdf).

INSERT INTO band.player (InstID, idband, pfname, plname, homecity, homestate)
VALUES (3, 22, 'Rivers', 'Cuomo', 'Rochester', 'NY'),
	   (1, 22, 'Brian', 'Bell', 'Iowa City', 'IA'),
       (4, 22, 'Patrick', 'Wilson', 'Buffalo', 'NY'),
       (2, 22, 'Scott', 'Shriner', 'Toledo', 'OH'),
       (3, 23, 'Tionne', 'Watkins', 'Des Moines', 'IA'),
       (3, 23, 'Rozonda', 'Thomas', 'Columbus', 'GA'),
       (3, 24, 'Hayley', 'Williams', 'Franklin', 'TN'),
       (1, 24, 'Taylor', 'York', 'Nashville', 'TN'),
       (4, 24, 'Zac', 'Farro', 'Voorhees Township', 'NJ'),
       (3, 25, 'Jisoo', 'Kim', NULL, 'South Korea'),
       (3, 25, 'Jennie', 'Kim', NULL, 'South Korea'),
       (3, 25, 'Roseanne', 'Park', NULL, 'New Zealand'),
       (3, 25, 'Lisa', 'Manoban', NULL, 'Thailand'),
       (3, 26, 'Ezra', 'Koenig', 'New York', 'NY'),
       (2, 26, 'Chris', 'Baio', 'Bronxville', 'NY'),
       (4, 26, 'Chris', 'Tomson', 'Upper Freehold Township', 'NJ');
       
-- Task 4: Add new venue information to the venue table

## Attribute            ## Value
# Venue                 Twin City Rock House
# City                  Minneapolis
# State                 Minnesota
# Zip Code              55414
# Seating capacity      2,000

INSERT INTO band.venue (vname, city, state, zipcode, seats)
VALUES('Twin City Rock House', 'Minneapolis', 'MN', '55414', 2000);

SELECT * FROM band.venue;

-- Task 5: 
/*Which state has the largest amount of seating available (regardless of the number of venues at the state)? 
Hint: We are trying to determine the total number of seats for each state */

SELECT state, SUM(seats) AS total_num_of_seats 
FROM band.venue
GROUP BY state
ORDER BY total_num_of_seats DESC; -- CA has the largest amount of seating available


######## Part 3: CASE Statements and Views in SQL 

-- Task 1: Which table should we use to add some data on upcoming performances for some of the artists?

/* Use the gig table to add some data on upcoming performances fro some artists */

-- Task 2: Using the table mentioned in Task 1 above, add the following information

## Venue                 ## Band                 ## Date             ## Expected Attendees
# TD Garden              Eminem				     May 5, 2022         19,000
# Twin City Rock House   Vampire Weekend		 April 15, 2022
# SAP Center             TLC                     June 7, 2022        18,000
# The River Club         Weezer                  July 3, 2022        175

SELECT * FROM band.venue;
SELECT * FROM band.band;
SELECT * FROM band.album;

INSERT INTO band.gig(idvenue, idband, gigdate, numattendees) 
VALUES(4, 2, '2022-05-05', 19000),
	  (12, 26, '2022-04-15', NULL),
      (8, 23, '2022-06-07', 18000),
      (2, 22, '2022-07-03', 175);

SELECT * FROM band.gig;

-- Task 3: Are any of the values oversold?
SELECT * FROM band.gig;
SELECT * FROM band.venue;

SELECT v.vname, b.bandname, g.gigdate, g.numattendees, v.seats, 
CASE WHEN g.numattendees > v.seats THEN TRUE   -- TRUE == 1
	 WHEN g.numattendees < v.seats THEN FALSE  -- FALSE == 0
     ELSE 'N/A' END AS 'Oversold?'
FROM band.gig AS g
INNER JOIN band.venue AS v
ON v.idvenue = g.idvenue
INNER JOIN band.band AS b
ON b.idband = g.idband;

-- Task 4: Write query to update the table to reflect that Vampire Weekend can expect 1,750 guests
UPDATE band.gig
SET numattendees = 1750
WHERE GigID = 2;

-- Task 5: Write a query to update the table now that the expected number of attendees at the River Club for Weezer will only have 125 guests
UPDATE band.gig
SET numattendees = 125
WHERE GigID = 4;

-- Task 6: 
/*Create a view (called vw-giginfo) that will show the band, the dates they will play, the venue they will play at, the number of attendees, and the 
value capacity. Also create a column that describes what percentage of the venue capacity was utilized
*/
CREATE VIEW band.vw_giginfo AS
SELECT b.bandname, g.gigdate, v.vname, g.numattendees, ROUND(g.numattendees * 100 / v.seats, 2) AS percent_venue_occupied
FROM band.gig AS g
INNER JOIN band.band AS b
ON g.idband = b.idband
INNER JOIN band.venue AS v
ON g.idvenue = v.idvenue;

SELECT * FROM vw_giginfo;
######## Part 4: Utilizing Basic Storage Procedures in SQL 

-- Task 1: Create a stored procedure that lists all of the venues that can handle more than 10,000 guests
DELIMITER $
CREATE PROCEDURE band.large_venue()
BEGIN
	SELECT vname FROM band.venue
	WHERE seats > 10000;
END $


call band.large_venue();


-- Task 2: 
/* Create a stored procedure that lists all of the players that come from a specific state. Once the store procedure is created, it should show
what bands they are apart of, their full name, and the state they are from */

DELIMITER $
CREATE PROCEDURE band.location_of_players(IN state_name VARCHAR(45))
BEGIN
	SELECT CONCAT(pfname, ' ', plname) AS playername, b.bandname AS Band ,p.homestate
	FROM band.player AS p
	INNER JOIN band.band AS b
	ON p.idband = b.idband
	WHERE p.homestate NOT IN ('Ireland', 'Canada', 'Australia', 'South Korea', 'New Zealand', 'Thailand')
    AND p.homestate = state_name
	GROUP BY CONCAT(pfname, ' ', plname);
END $

call band.location_of_players('Tennessee');

