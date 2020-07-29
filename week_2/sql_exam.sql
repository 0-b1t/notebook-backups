--1

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';


-- 2

SELECT * 
FROM naep 
LIMIT 50;


--3

SELECT 	state
		, ROUND(AVG(avg_math_4_score), 2) AS avg_of_scores
		, ROUND(SUM(avg_math_4_score), 2) AS sum_of_scores
		, MIN(avg_math_4_score) AS min_score
		, MAX(avg_math_4_score) AS max_score
FROM naep
GROUP BY state
ORDER BY state;


--4

SELECT 	state
		, ROUND(AVG(avg_math_4_score), 2) AS avg_of_scores
		, ROUND(SUM(avg_math_4_score), 2) AS sum_of_scores
		, MIN(avg_math_4_score) AS min_score
		, MAX(avg_math_4_score) AS max_score
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY state;


--5

