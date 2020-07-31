-- Using the fueleconomy database

----------------------------
-- Subqueries---------------
---------------------------=
-- Find the average highway mileage for all records of 
-- whatever make produces the model 'A4'.




-- Part 1 of answering this question: 
-- Who makes 'A4'?
SELECT make
FROM vehicles
WHERE model = 'A4';

SELECT DISTINCT
	make
FROM
	vehicles
WHERE
	model LIKE '%A4%'


SELECT DISTINCT make
FROM vehicles
WHERE model = 'A4';

-- Part 2: filter
SELECT ROUND(AVG(hwy), 2)
FROM vehicles
WHERE make = 'Audi';

-- A subquery can allow us to do both of this parts
-- at once.
SELECT ROUND(AVG(hwy), 2)
FROM vehicles
WHERE make = 
	(SELECT DISTINCT make
	FROM vehicles
	WHERE model = 'A4');


-- Subqueries are not limited to the WHERE clause
-- Say we want to compare each car to the average 
-- hwy mpg. Write a query to grab the model, hwy, 
-- and a column showing how far above/below the car's
-- hwy is from average.

SELECT 
	model
	,hwy - 
		(SELECT ROUND(AVG(hwy))
		FROM vehicles) AS hwy_diff
FROM 
	vehicles
ORDER BY 
	hwy_diff DESC;
-- Perform the same task as above, but instead
-- of comparing to the overall average hwy, compare
-- to the average for the current records make.
-- (i.e. a bmw row in the output should be compared to
-- to the average bmw hwy mpg)

SELECT ROUND(AVG(hwy))
FROM vehicles
GROUP BY make;

SELECT 
	model
	,v.make
	,hwy
	,v.hwy-m. avg_per_make
FROM vehicles AS v
INNER JOIN 
	(SELECT make, 
	 ROUND(AVG(hwy),2) AS avg_per_make 
	 FROM vehicles 
	 GROUP BY make) AS m
ON v.make= m.make;

-- Write a query to only select records with 
-- above average hwy.

SELECT 
	*
FROM 
	vehicles
WHERE
	hwy - 
		(SELECT ROUND(AVG(hwy))
		FROM vehicles) >0;
			 
-- Let's switch focus to makes.  Show the average
-- hwy mpg by make, but only show makes who have
-- average hwy mpg greater than the average hwy
-- mpg in the vehicles table.

SELECT 
	make
	,ROUND(AVG(hwy), 2) AS avg_hwy
FROM 
	vehicles
GROUP BY make
HAVING
	AVG(hwy) > 
		(SELECT ROUND(AVG(hwy))
		FROM vehicles);

-- Rewrite using a Common Table Expression (CTE)

WITH avg_hwy AS (
	SELECT ROUND(AVG(hwy), 2)
	FROM vehicles	
)

--SELECT * FROM avg_hwy;

SELECT 
	make
	,ROUND(AVG(hwy), 2)
FROM 
	vehicles
GROUP BY 
	make
HAVING AVG(hwy) > (SELECT * FROM avg_hwy);
-- Using SQL and the vehicles table from the fueleconomy database, do the following:
-- Find the average of minimum highway mileages for records when grouped by make.
-- what... lets unpack it
-- Find the min hwy mileage per make and then take the average of it

-- Let's use a CTE for this

WITH min_make_hwy AS (
	SELECT
		make
		,MIN(hwy) AS min_hwy
	FROM 
		vehicles
	GROUP BY
		make
)

SELECT ROUND(AVG(min_hwy),2)
FROM min_make_hwy;

