SELECT * FROM people LIMIT 10;

-- 2

SELECT namefirst, namelast, inducted
FROM people AS p
LEFT JOIN hof_inducted AS h
ON p.playerid = h.playerid;

--3

SELECT birthyear, deathyear, namefirst, namelast, birthcountry
FROM people AS p
LEFT JOIN hof_inducted AS h
ON p.playerid = h.playerid
WHERE h.votedby = 'Negro League' AND yearid = 2006;

--4

SELECT
	s.yearid
	,s.playerid
	,s.teamid
	,s.salary
	,h.category
FROM salaries AS s
JOIN hof_inducted AS h
ON s.playerid = h.playerid; 

--5

SELECT
	s.yearid
	,s.playerid
	,s.teamid
	,s.lgid
	,s.salary
	,h.inducted
FROM salaries AS s
FULL OUTER JOIN hof_inducted AS h
ON s.playerid = h.playerid; 
	
	
--6
--6.1

SELECT * 
FROM hof_inducted
UNION
SELECT *
FROM hof_not_inducted;

--6.2

SELECT DISTINCT playerid
FROM 
	(
	SELECT * 
	FROM hof_inducted
	UNION
	SELECT *
	FROM hof_not_inducted
	) AS hof_all
;

--7

SELECT 
	p.namefirst
	,p.namelast
	,COUNT(s.salary)
FROM people AS p
JOIN salaries AS s
ON p.playerid = s.playerid
GROUP BY p.playerid;

--8

SELECT 
	h.playerid
	,h.yearid
	,p.namefirst
	,p.namelast
FROM hof_inducted AS h
LEFT OUTER JOIN people AS p
ON h.playerid = p.playerid
UNION
SELECT 
	nh.playerid
	,nh.yearid
	,p.namefirst
	,p.namelast
FROM hof_not_inducted AS nh
LEFT OUTER JOIN people AS p
ON nh.playerid = p.playerid;

--9

WITH hof_full AS
	(
	SELECT 
		p.playerid
		,p.namelast
		,p.namefirst
		,h.yearid
		,h.inducted
	FROM hof_inducted AS h
	LEFT OUTER JOIN people AS p
	ON h.playerid = p.playerid
	UNION
	SELECT 
		p.playerid
		,p.namelast
		,p.namefirst
		,nh.yearid
		,nh.inducted
	FROM hof_not_inducted AS nh
	LEFT OUTER JOIN people AS p
	ON nh.playerid = p.playerid 
	)
SELECT
	namelast || ', ' || namefirst AS namefull
	,yearid
	,inducted
FROM hof_full
ORDER BY inducted DESC, namefull;

--10 kinda hacky
WITH max_ann_sal AS
	(SELECT MAX(salary) AS max_sal, teamid
	FROM salaries
	GROUP BY teamid)

SELECT playerid, salary, ma.teamid
FROM salaries as s
JOIN max_ann_sal as ma
ON ma.max_sal = s.salary
ORDER BY salary DESC;


-- 11

SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear >= 
	(SELECT birthyear
	FROM people
	WHERE playerid = 'ruthba01')
ORDER BY birthyear;

--12

SELECT namefirst, namelast,
		CASE
		WHEN birthcountry = 'USA' THEN 'USA'
		ELSE 'non-USA'
		END AS usaborn
FROM people;

--13 pretty janky

SELECT
	CASE
	WHEN throws = 'R' THEN AVG(height)
	END AS right_height,
	CASE
	WHEN throws = 'L' THEN AVG(height)
	END AS left_height
FROM people
GROUP BY throws;

--14

WITH max_sal_by_year AS 
	( SELECT MAX(salary) AS max_sal, yearid, teamid
	 FROM salaries
	 GROUP BY yearid, teamid
	)
	
SELECT ROUND(AVG(max_sal)), teamid
FROM max_sal_by_year
WHERE yearid>=2010
GROUP BY teamid;