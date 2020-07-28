SELECT ROUND(AVG(saleprice), 0) AS avg_saleprice, neighborhood
FROM houseprices
WHERE yrsold = 2010
GROUP BY neighborhood
HAVING ROUND(AVG(saleprice), 0) > 200000
ORDER BY avg_saleprice DESC;


SELECT MAX(lotarea) AS max_lotarea, mszoning
FROM houseprices
WHERE yearbuilt > 1950
GROUP BY mszoning
HAVING MAX(lotarea)>10000
ORDER BY max_lotarea DESC;