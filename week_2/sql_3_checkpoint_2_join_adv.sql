

SELECT empno, ename, dept.deptno, dname
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dname
FROM emp FULL OUTER JOIN dept
ON emp.deptno = dept.deptno;

--------------------------------------

SELECT empno, ename, emp.deptno, dname, cty, state
FROM emp

LEFT OUTER JOIN dept
ON emp.deptno = dept.deptno

LEFT OUTER JOIN loc
ON dept.locno = loc.locno;