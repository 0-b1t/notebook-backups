SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
WHERE mgr = 7698;


SELECT emp.deptno, dname, SUM(sal)
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
GROUP BY emp.deptno, dname;


SELECT emp.deptno, dname, SUM(sal) AS dept_salary
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno
WHERE empno BETWEEN 7500 AND 8000
GROUP BY emp.deptno, dname
HAVING SUM(sal) > 3000
ORDER BY dname;

-----------------------------------

SELECT deptno, dname, locno FROM dept
UNION
SELECT deptno, dname, locno FROM dept2;


SELECT locno FROM dept
UNION ALL
SELECT locno FROM dept2;


SELECT locno FROM dept      --Won't show duplicate records
UNION
SELECT locno FROM dept2;


SELECT * FROM dept
WHERE locno <> 50
UNION
SELECT * FROM dept2
WHERE locno <> 50
ORDER BY deptno;