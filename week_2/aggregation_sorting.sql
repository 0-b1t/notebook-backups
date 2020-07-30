-- Using table: fueleconomy.public.vehicles
-- No context for these prompts :(  Straight to business.

-- How many records are in the vehicles table?
SELECT COUNT(*)
FROM vehicles;

-- How many records are there that use Diesel fuel?
SELECT COUNT(*)
FROM vehicles
WHERE fuel = 'Diesel';


-- How many non-NULL records are there in the cyl column?
-- 33442
SELECT COUNT(*)
FROM vehicles;

-- 33384
SELECT COUNT(cyl)
FROM vehicles;

-- 33384
SELECT COUNT(*)
FROM vehicles
WHERE cyl IS NOT NULL;


-- Can you explain why the cyl column has NULLs?
SELECT *
FROM vehicles
WHERE cyl IS NULL;


-- List the unique fuel types when cyl is NULL
SELECT DISTINCT fuel
FROM vehicles
WHERE cyl IS NULL;


-- Count the unique number of makes when cyl is NULL
SELECT COUNT(DISTINCT make), COUNT(model), COUNT(DISTINCT model)
FROM vehicles
WHERE cyl IS NULL;


-- Find unique make model pairs where cyl is NULL
SELECT DISTINCT make, model
FROM vehicles
WHERE cyl IS NULL;


-- What is the average hwy mpg? cty mpg?
SELECT ROUND(AVG(hwy), 2), ROUND(AVG(cty), 2)
FROM vehicles;


-- What brands make the most fuel efficient cars?
-- Include a count of the number of records for each make to get
-- additional perspective?
SELECT make,
       ROUND(AVG(hwy), 2) AS avg_hwy, 
       ROUND(AVG(cty), 2) AS avg_cty,
	   COUNT(*)
FROM vehicles
GROUP BY make
ORDER BY avg_hwy DESC, avg_cty DESC;


-- Redo the last analysis but with a minimum number of records for
-- a make to be elligible.  Let's say 1000 to be considered.
SELECT make,
       ROUND(AVG(hwy), 2) AS avg_hwy, 
       ROUND(AVG(cty), 2) AS avg_cty,
	   COUNT(*)
FROM vehicles
GROUP BY make
HAVING COUNT(*) > 1000
ORDER BY avg_hwy DESC, avg_cty DESC;


-- Redo the last analysis but only consider any type of 'Regular' fuel.
-- So our question were answering now.  Which large* makes produce
-- the most fuel efficient cars (where large is >1000 records)?
SELECT make,
       ROUND(AVG(hwy), 2) AS avg_hwy, 
       ROUND(AVG(cty), 2) AS avg_cty,
	   COUNT(*)
FROM vehicles
WHERE fuel ILIKE '%regular%'
GROUP BY make
HAVING COUNT(*) > 1000
ORDER BY avg_hwy DESC, avg_cty DESC;

-- What fuel types did we even exclude above?
SELECT DISTINCT fuel
FROM vehicles
WHERE NOT fuel ILIKE '%regular%';


-- What are the top 5 most fuel efficient cars that
-- have any type of four-wheel or all-wheel drive?

-- Note, multiple records for make/model/year combination
-- use business sense and client as a resource of best agg function
SELECT
	make,
	model,
	year,
	ROUND(AVG(hwy), 2) AS avg_hwy_mpg,
	ROUND(AVG(cty), 2) AS avg_cty_mpg,
	COUNT(*) AS n
FROM 
	vehicles
WHERE drive LIKE '%All%' OR drive LIKE '%4%'
GROUP BY 
	model, make, year
ORDER BY n DESC, avg_hwy_mpg DESC, avg_cty_mpg DESC
LIMIT 5;


-- Create a report that shows the worst & best hwy mpg before 1990
-- and after 1990
SELECT CASE
         WHEN year > 1990 THEN 'After 1990'
         WHEN year < 1990 THEN 'Before 1990'
		 ELSE '1990'
       END AS year_label,
	   MIN(hwy) AS worst_hwy_mpg,
	   MAX(hwy) AS best_hwy_mpg,
	   COUNT(*) AS n
FROM vehicles
WHERE NOT fuel ILIKE '%Electricity%'
GROUP BY year_label;
