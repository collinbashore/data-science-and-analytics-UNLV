SELECT * FROM stars.stars;

SELECT AVG(Luminosity) AS avg_luminosity FROM stars.stars;

SELECT AVG(Luminosity) 
FROM stars.stars
WHERE Color = 'Yellow-White';

-- Used a windows function to number the stars by row
SELECT ROW_NUMBER() OVER() AS Star, Temp, Color 
FROM stars.stars
ORDER BY Temp DESC
LIMIT 5;