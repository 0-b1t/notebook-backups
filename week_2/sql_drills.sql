--ITEM 2
--How many distinct values are there in the "country" field?
SELECT COUNT(DISTINCT country)
FROM ksprojects;

-- ITEM 3
--Write a query that returns the average number of backers per main_category, 
--rounded to the nearest whole number and sorted from high to low. 
--What is the numerical value of the first row in the returned dataset?

SELECT ROUND(AVG(backers)), main_category
FROM ksprojects
GROUP BY main_category
ORDER BY AVG(backers) DESC;


--ITEM 4
--Write a query that shows, for each category, 
--how many campaigns were successful 
--and the average difference per project between dollars pledged 
--and the goal for successful campaigns in that category. 
--Which category raised the most (pledged) above and beyond its goal amount?

SELECT 	COUNT(category), 
		category,
		SUM(usd_pledged-goal)/COUNT(category) AS avg_per_category,
		SUM(usd_pledged-goal) AS total_diff
FROM ksprojects
WHERE state LIKE 'successful'
GROUP BY category
ORDER BY avg_per_category DESC;

--SELECT * FROM ksprojects LIMIT 50;

--ITEM 5
--Write a query that shows, for each main_category, 
--how many successful projects had between 5 and 10 backers. 
--How many "Publishing" projects meet this criteria? 

SELECT COUNT(category), category
FROM ksprojects
WHERE state LIKE('successful') AND backers BETWEEN 5 AND 10
GROUP BY category
ORDER BY category;

--ITEM 6
--Excluding Games and Technology records in the main_category field,
--return the total of all backers for successful projects by main_category
--where the total number of backers was over 100,000.  
--Sort by main_category from A-Z. 
--How many backers does the first record have?


SELECT COUNT(backers), main_category
FROM ksprojects
WHERE main_category NOT IN ('Games', 'Technology')
GROUP BY main_category
ORDER BY main_category;


