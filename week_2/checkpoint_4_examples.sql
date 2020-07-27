SELECT yearbuilt, saleprice
FROM houseprices
WHERE yearbuilt BETWEEN 1990 AND 2000
ORDER BY yearbuilt DESC, saleprice DESC;


SELECT *
FROM houseprices
ORDER BY id DESC
LIMIT 100;

SELECT saleprice
FROM houseprices
WHERE yearbuilt < 1950
ORDER BY saleprice DESC
LIMIT 10;

SELECT 10 * overallcond
FROM houseprices;


SELECT COUNT(*) AS count_records
FROM houseprices;

SELECT COUNT(yearbuilt) AS count_yearbuilt, COUNT(alley) AS count_alley
FROM houseprices;


SELECT COUNT(*)
FROM houseprices
WHERE alley IS NULL;



SELECT COUNT(*)
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950;


SELECT DISTINCT neighborhood
FROM houseprices;


SELECT DISTINCT neighborhood
FROM houseprices;

SELECT DISTINCT yearbuilt, neighborhood
FROM houseprices
ORDER BY neighborhood, yearbuilt DESC;

