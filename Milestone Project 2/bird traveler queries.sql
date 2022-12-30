########### SQL Queires for Bird Traveler Profiles ##################

-- Query 1: Select all columns from the city_weather table and read only the first five rows
SELECT * 
FROM city_weather 
LIMIT 5;

-- Query 2: Select all columns from the bird_data table and read only the first five rows
SELECT * 
FROM bird_data 
LIMIT 5;

-- Query 3: Join the bird_data and city_weather tables
SELECT bird.*, city.avg_temp 
FROM bird_data AS bird 
LEFT JOIN city_weather AS city 
ON bird.date = city.DATE 
AND bird.nearest_city = city.CITY 
ORDER BY bird.id;

/* 
NOTE: In the Jupyter Notebook "Milestone Project 2 Traveler Profiles for Bird-Sighters", the "date" column was deleted
using Python since the "date" column from the bird_data table is redundant. See the Jupyter Notebook to see how this 
query was executed using Python
*/