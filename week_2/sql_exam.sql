--1

SELECT 
	column_name
	,data_type
FROM 
	information_schema.columns
WHERE 
	table_name = 'naep';


-- 2

SELECT * 
FROM naep 
LIMIT 50;


-- 3

SELECT
	state
	,ROUND(AVG(avg_math_4_score), 2) AS avg_of_scores
	,ROUND(SUM(avg_math_4_score), 2) AS sum_of_scores
	,MIN(avg_math_4_score) AS min_score
	,MAX(avg_math_4_score) AS max_score
FROM 
	naep
GROUP BY 
	state
ORDER BY 
	state;


-- 4

SELECT
	state
	,ROUND(AVG(avg_math_4_score), 2) AS avg_of_scores
	,ROUND(SUM(avg_math_4_score), 2) AS sum_of_scores
	,MIN(avg_math_4_score) AS min_score
	,MAX(avg_math_4_score) AS max_score
FROM 
	naep
GROUP BY 
	state
HAVING 
	MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY 
	state;


-- 5

SELECT 
	state
	,avg_math_4_score
FROM 
	naep
WHERE 
	year = 2000 
	AND avg_math_4_score IS NOT NULL
ORDER BY 
	avg_math_4_score
LIMIT 10;

-- 6 

SELECT 
	ROUND(AVG(avg_math_4_score),2)
FROM 
	naep
WHERE 
	year = 2000;

-- 7

SELECT state, avg_math_4_score,
	CASE
		WHEN avg_math_4_score < 
			(
				SELECT ROUND(AVG(avg_math_4_score),2)
				FROM naep
				WHERE year = 2000
			) THEN 'Below'
		ELSE 'Above'
	END below_average_states_y2000
FROM 
	naep
WHERE 
	year = 2000 
	AND avg_math_4_score IS NOT NULL 
	AND avg_math_4_score < 
		(
			SELECT ROUND(AVG(avg_math_4_score),2)
			FROM naep
			WHERE year = 2000
		) 
ORDER BY 
	avg_math_4_score;
	
-- 8

SELECT 
	state
	,avg_math_4_score
		,CASE
			WHEN year = 2000 AND avg_math_4_score IS NULL THEN 'Y'
			ELSE 'N'
		END AS scores_missing_y2000
FROM 
	naep
WHERE 
	year = 2000
ORDER BY 
	scores_missing_y2000 DESC;

-- 9

SELECT ROUND(n.avg_math_4_score,2), f.total_expenditure, n.state
FROM naep AS n
LEFT OUTER JOIN finance as f
ON n.id = f.id
WHERE n.year = 2000 AND n.avg_math_4_score IS NOT NULL
ORDER BY f.total_expenditure DESC;

