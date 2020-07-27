SELECT COUNT(*)
FROM vehicles;


SELECT COUNT(*)
FROM vehicles
WHERE year BETWEEN 2010 AND 2015;

SELECT COUNT(*)
FROM vehicles
WHERE year BETWEEN 1987 AND 2005
	AND year != 1990
	AND year != 2000;


SELECT year, make, model, (cty+hwy)/2 AS average_mpg
FROM vehicles
LIMIT 100;


SELECT COUNT(*)
FROM vehicles
WHERE make IN ('Ford', 'Chevrolet') AND CLASS IN ('Compact Cars', 'Two Seaters');

SELECT DISTINCT class
FROM vehicles;



SELECT *
FROM vehicles
WHERE year >=2000
	AND model LIKE('X%')
ORDER BY make;

SELECT *
FROM vehicles
WHERE model LIKE '__X%';

