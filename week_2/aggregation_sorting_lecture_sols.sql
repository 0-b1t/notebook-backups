-- Using table: fueleconomy.public.vehicles
-- No context for these prompts :(  Straight to business.

SELECT * FROM vehicles LIMIT 10;

-- How many records are in the vehicles table?

SELECT COUNT(*)
FROM vehicles;


-- How many records are there that use Diesel fuel?

SELECT COUNT(*)
FROM vehicles
WHERE fuel LIKE 'Diesel';


-- How many non-NULL records are there in the cyl column?

SELECT COUNT(cyl)
FROM vehicles;



-- Can you explain why the cyl column has NULLs?

SELECT *
FROM vehicles
WHERE cyl IS NULL;


-- List the unique fuel types when cyl is NULL

SELECT COUNT(DISTINCT fuel)
FROM vehicles
WHERE cyl IS NULL;
--GROUP BY fuel;


-- Count the unique number of makes when cyl is NULL

SELECT COUNT(DISTINCT make)
FROM vehicles
WHERE cyl IS NULL;


-- What is the average hwy mpg? cty mpg?

SELECT ROUND(AVG(hwy), 2), ROUND(AVG(cty), 2)
FROM vehicles;

-- What brands make the most fuel efficient cars?
-- Include a count of the number of records for each make to get
-- additional perspective?

SELECT 	ROUND(AVG(hwy)) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(make) AS num_records
FROM vehicles
GROUP BY make
ORDER BY h_avg DESC, c_avg DESC;

---------------------------------------Lecture Solution

SELECT 	ROUND(AVG(hwy),2 ) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(*)
FROM vehicles
GROUP BY make
ORDER BY h_avg DESC, c_avg DESC;

-- Redo the last analysis but with a minimum number of records for
-- a make to be elligible.  Let's say 1000 to be considered.

SELECT 	ROUND(AVG(hwy)) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(make) AS num_records
FROM vehicles
GROUP BY make
HAVING COUNT(make) > 1000
ORDER BY h_avg DESC, c_avg DESC;

---------------------------------Lecture Solution

SELECT 	ROUND(AVG(hwy)) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(*)
FROM vehicles
GROUP BY make
HAVING COUNT(*) > 1000
ORDER BY h_avg DESC, c_avg DESC;


-- Redo the last analysis but only consider Regular fuel.
-- So our question were answering now.  Which large* makes produce
-- the most fuel efficient cars (where large is >1000 records)?

SELECT 	ROUND(AVG(hwy)) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(make) AS num_records
FROM vehicles
WHERE fuel = 'Regular'
GROUP BY make
HAVING COUNT(make) > 1000
ORDER BY h_avg DESC, c_avg DESC;

---------------------------------------

SELECT 	ROUND(AVG(hwy)) AS h_avg
		, ROUND(AVG(cty)) AS c_avg
		, make
		, COUNT(*)
FROM vehicles
WHERE fuel NOT ILIKE '%regular%'
GROUP BY make
HAVING COUNT(*) > 1000
ORDER BY h_avg DESC, c_avg DESC;

-- What are the top 5 most fuel efficient cars that
-- have any type of four-wheel or all-wheel drive

SELECT 	hwy, cty, model, drive
FROM vehicles
WHERE	drive ILIKE '%4-wheel%' OR 
		drive ILIKE '%all-wheel%'
ORDER BY hwy DESC, cty DESC
LIMIT 5;

------------

--Note, multiple records for make/model/year
--use business sense and client to figure out best agg

SELECT
	make,
	model,
	year,
	ROUND(AVG(hwy), 2) AS avg_hwy_mpg,
	ROUND(AVG(cty), 2) AS avg_cty_mpg
FROM 
	vehicles
WHERE drive LIKE '%All%' OR drive LIKE '%4%'
GROUP BY 
	model, make, year
ORDER BY avg_hwy_mpg DESC, avg_cty_mpg DESC
LIMIT 5;


-- Create a report that shows the worst & best hwy mpg before 1990
-- and after 1990

SELECT
		CASE
			WHEN year > 1990 THEN 'After 1990'
			WHEN year < 1990 THEN 'Before 1990'
			ELSE '1990'
		END year_label,
		MIN(hwy) AS worst_hwy_mpg,
		MAX(hwy) AS best_hwy_mpg,
		COUNT(*) AS n
FROM vehicles
WHERE NOT fuel LIKE '%Electricity%'
GROUP BY year_label;


