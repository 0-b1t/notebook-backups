SELECT DISTINCT yearbuilt
FROM houseprices
WHERE yearbuilt>50;


SELECT DISTINCT yearbuilt, neighborhood
FROM houseprices;

SELECT DISTINCT yearbuilt, DISTINCT neighborhood --doesn't run
FROM houseprices;


SELECT COUNT(DISTINCT yearbuilt), COUNT(DISTINCT neighborhood)
FROM houseprices;


--Aggregated data likes to display with other aggregates

SELECT COUNT(neighborhood), yearbuilt  --Throws an error
FROM houseprices;

SELECT neighborhood, COUNT(DISTINCT(yearbuilt))
FROM houseprices
GROUP BY neighborhood;



SELECT COUNT(neighborhood), yearbuilt
FROM houseprices
GROUP BY yearbuilt;

--To reorder the output

SELECT yearbuilt AS yearbuilt, COUNT(neighborhood) AS number_of_neighborhoods
FROM houseprices
GROUP BY yearbuilt;


SELECT COUNT(*), neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY neighborhood;

SELECT COUNT(*) AS count_houses, neighborhood
FROM houseprices
WHERE saleprice > 100000 AND yearbuilt < 1950
GROUP BY neighborhood
ORDER BY count_houses DESC;



SELECT COUNT(*), yearbuilt
FROM houseprices
GROUP BY yearbuilt
ORDER BY yearbuilt DESC;

--Can do multiple group bys


SELECT COUNT(*), yearbuilt, housestyle
FROM houseprices
GROUP BY yearbuilt, housestyle
ORDER BY yearbuilt DESC;

--reorder things

SELECT yearbuilt, housestyle, COUNT(*)
FROM houseprices
GROUP BY yearbuilt, housestyle
ORDER BY yearbuilt DESC, housestyle;


SELECT COUNT(*) AS count_records, COUNT(alley) as count_alleys, neighborhood
FROM houseprices
GROUP BY neighborhood
ORDER BY count_alleys ASC;

SELECT COUNT(*) AS count_records, COUNT(alley) as count_alleys, neighborhood
FROM houseprices
GROUP BY neighborhood, street
ORDER BY count_alleys ASC;


SELECT COUNT(roofstyle), neighborhood
FROM houseprices
GROUP BY neighborhood, roofstyle;

SELECT neighborhood, roofstyle, COUNT(roofstyle) AS count_roofstyle
FROM houseprices
GROUP BY roofstyle, neighborhood
ORDER BY neighborhood, roofstyle, count_roofstyle;
