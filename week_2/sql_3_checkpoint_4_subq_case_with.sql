SELECT ename
FROM emp
WHERE sal >
	(SELECT sal
	FROM emp
	WHERE empno = 7782);
	
	
SELECT ename, job, hiredate
FROM emp
WHERE deptno = 
	(SELECT deptno
	FROM emp
	WHERE empno = 7782);
	
	
SELECT ename, sal, deptno
FROM emp
WHERE sal IN
	(SELECT MAX(sal)
	FROM emp
	GROUP BY deptno);
	
	
SELECT empno, ename, job, sal
FROM emp
WHERE sal > ANY
	(SELECT sal
	FROM emp
	WHERE job = 'CLERK')
AND job <> 'CLERK';


SELECT empno, ename, job, sal
FROM emp
WHERE sal > ALL
	(SELECT sal
	FROM emp
	WHERE job = 'CLERK');
	


SELECT ename, job, hiredate
FROM emp
WHERE hiredate < ALL
	(SELECT hiredate
	FROM emp
	WHERE job = 'MANAGER');


SELECT ename, job, hiredate
FROM emp
WHERE hiredate < ANY
	(SELECT hiredate
	FROM emp
	WHERE job = 'MANAGER');


SELECT	empno, ename, sal,
		CASE
			WHEN sal >= 2000 THEN 'HIGH'
			WHEN sal BETWEEN 1000 AND 1999 THEN 'MEDIUM'
			ELSE 'LOW'
		END AS salary_level
FROM emp
ORDER BY sal DESC, salary_level;



SELECT job,
		AVG(CASE WHEN sal < 999 THEN 1 WHEN sal > 1000 THEN 0 END) AS pct_lt1000,
		AVG(CASE WHEN sal < 999 THEN 0 WHEN sal > 1000 THEN 1 END) AS pct_gt1000
FROM emp
GROUP BY job;

-------------------------------


WITH title_sal AS
	(
		SELECT job, AVG(sal) AS avg_sal
		FROM emp
		GROUP BY job
	)
SELECT * FROM title_sal
		WHERE avg_sal>1500;
		

WITH avg_title_sal AS
	(
		SELECT job, AVG(sal) AS avg_sal
		FROM emp
		GROUP BY job
	)
SELECT AVG(avg_sal) AS avg_title_sal
		FROM avg_title_sal;