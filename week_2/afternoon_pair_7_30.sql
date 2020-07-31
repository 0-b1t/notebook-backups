CREATE TABLE IF NOT EXISTS normal AS
SELECT *
FROM houseprices
WHERE salecondition = 'Normal';

DROP TABLE IF EXISTS normal_sales;

CREATE TABLE IF NOT EXISTS normal_sales AS
SELECT *
FROM houseprices
WHERE salecondition = 'Normal';

DELETE FROM normal_sales
WHERE neighborhood = 'Veenker';


--Re-insert the Veenker neighborhood normal sale condition records.
--For all properties where the sale price was greater than $300,000, 
--update the overall condition to be equal to the overall quality.
--Using your choice of subquery, temp table, or CTE, 
--calculate average sale prices by neighborhood and 
--then compute what percentage more or less every property sold for compared to the average for their neighborhood.

INSERT INTO normal_sales
SELECT * 
FROM houseprices
WHERE neighborhood = 'Veenker';


UPDATE normal_sales
SET overallcond = overallqual
WHERE saleprice > 300000;

SELECT saleprice
FROM normal_sales
WHERE overallcond = overallqual;

WITH nbrhood_avg AS
	(SELECT 
	 	ROUND(AVG(saleprice),2) AS avg_price
		,neighborhood as neighborhood
	FROM
	 	houseprices
	 GROUP BY
	 	neighborhood
)
--SELECT * FROM nbrhood_avg;

SELECT saleprice,
	id,
	houseprices.neighborhood,
	ROUND((saleprice - avg_price)/saleprice, 2) * 100 AS percent_diff
FROM houseprices
	JOIN nbrhood_avg
		ON houseprices.neighborhood = nbrhood_avg.neighborhood
;

