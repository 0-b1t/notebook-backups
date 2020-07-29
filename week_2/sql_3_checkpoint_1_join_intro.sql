SELECT * FROM emp LIMIT 10;

SELECT * FROM dept LIMIT 10;

SELECT *
FROM emp INNER JOIN dept  --INNER is technically unneeded because default for JOIN
ON emp.deptno = dept.deptno; --returns a table with deptno twice, one from each table


SELECT empno, ename, emp.deptno, dname  --explicitly ask for the columns you want
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno;



SELECT empno, ename, emp.deptno, dname  --will return all fields from from emp
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;

SELECT empno, ename, emp.deptno, dname  --will return all fields from dept
FROM dept LEFT OUTER JOIN emp
ON emp.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dname
FROM emp LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno;
