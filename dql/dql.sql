/*
1.查询列表可以是:表中的字段、常量值、表达式、函数
2.查询结果是一个虚拟的表格
*/
USE bookstore;
#1.查询表中的单个字段
select first_name
from employees;
#2.查询表中的多个字段
select first_name, last_name, email
from employees;
#3.查询表中所有字段
#方式一：
SELECT *
FROM employees;
#方式二：
SELECT employee_id, first_name, last_name, email, phone_number, job_id, salary, commission_pct, manager_id, department_id, hiredate
FROM employees;
#4.常量查询
SELECT 100;
SELECT 'Mathematics';
#5.查询表达式
SELECT 100*99;
#6.查询函数
SELECT VERSION();
#7.起别名
/*
1.便于理解
2.如果查询的字段有重名的情况，使用别名可以区分开来
*/
#方法一：使用AS
SELECT 100%98 AS 取模结果;
#ShuwenHE
#first_name Shuwen
#last_name He
SELECT first_name AS 名, last_name AS 姓
FROM employees;
#方法二：使用空格
SELECT first_name  名, last_name  姓
FROM employees;
#查询salary
SELECT salary AS "out put"
FROM employees;
#8.去重
SELECT DISTINCT department_id
FROM employees;
#9.加号作用
SELECT 1+2;
SELECT '1'+2;
SELECT 'shuwen'+1;
SELECT NULL+1;
#10.使用concat实现连接
SELECT CONCAT(first_name,last_name) AS 姓名
from employees;

#11.条件运算符---查询工资>80000的员工信息
SELECT *
FROM employees
WHERE salary > 80000;

#查询部门编号不等于90号的员工名和部门编号
SELECT CONCAT(first_name,last_name) AS 姓名, department_id AS 部门
FROM employees
WHERE department_id <> 1;

#12.逻辑运算符
#查询工资在60000到80000之间的员工名、工资以及奖金
SELECT CONCAT(first_name,last_name) AS 姓名, salary, commission_pct
FROM employees
WHERE salary > 60000 and salary < 80000;

#查询部门编号不是在2到4之间，或者工资高于80000的员工信息
#---<2----4>----
SELECT *
FROM employees
WHERE department_id <2 OR department_id > 4 OR salary > 80000;
SELECT *
FROM employees
WHERE NOT(department_id > 2 AND department_id < 4) OR salary > 80000;

#13.模糊查询
#查询员工姓名中包含字母r的员工信息
SELECT *
FROM employees
WHERE first_name LIKE '%r%';
#查询员工姓名中第三个字母为c第5个字母为a的员工姓名和工资
SELECT CONCAT(first_name,last_name) AS 姓名, salary AS 工资
FROM employees
WHERE first_name LIKE '__c_a%';
#查询员工姓名中带下划线的员工信息
SELECT *
FROM employees
WHERE first_name LIKE '_\_%';
SELECT *
FROM employees
WHERE first_name LIKE '_$_%' ESCAPE '$';

#BETWEEN AND
#查询员工编号在2到4的员工信息
#1. AND
SELECT *
FROM employees
WHERE department_id >=2 AND department_id <=4;
#2.BETWEEN AND
SELECT *
FROM employees
WHERE department_id BETWEEN 2 AND 4;

#模糊查询In关键词
#查询员工job_id是AD_PRES或IT_PROG的员工姓名和job_id
SELECT CONCAT(first_name,last_name), job_id
FROM employees
WHERE job_id = 'AD_PRES' OR job_id='IT_PROG';
SELECT CONCAT(first_name,last_name), job_id
FROM employees
WHERE job_id IN('AD_PRES','IT_PROG');

#is not null模糊查询
#查询有奖金的员工姓名和奖金率
SELECT CONCAT(first_name,last_name), commission_pct
FROM employees
WHERE commission_pct is not NULL;

#安全等于<=>
#查询没有奖金的员工名和奖金率
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct <=> NULL;

#查询没有奖金的员工名和奖金率
SELECT first_name, salary, commission_pct
FROM employees
WHERE salary <=> 50000;

#查询员工编号为1的员工名和年薪
SELECT CONCAT(first_name,last_name) AS 姓名, salary*12*(1+commission_pct) AS 年薪
FROM employees
WHERE employee_id = 1;

#查询没有奖金且工资小于40000的员工名和薪资
SELECT first_name, salary
FROM employees
WHERE commission_pct
is NULL AND salary < 40000;

#IFNULL函数
SELECT IFNULL(commission_pct,0)
FROM employees;

#ISNULL
SELECT ISNULL(commission_pct), commission_pct
FROM employees;

#LIKE模糊查询
SELECT *
FROM employees
WHERE department_id 
LIKE '1__';

#3.排序查询

#desc降序
#查询员工信息，要求工资从高到低排序
SELECT *
FROM employees
ORDER BY salary DESC;

#asc升序
#查询员工信息，要求工资从低到高排序
SELECT *
FROM employees
ORDER BY salary ASC;

#升序
#查询员工信息，要求工资从低到高排序
SELECT *
FROM employees
ORDER BY salary;

#查询部门编号>=90的员工信息，按入职时间的先后进行排序
SELECT *
FROM employees
WHERE department_id >= 90
ORDER BY hiredate ASC;

#按表达式排序-按年薪的高低显示员工的信息和年薪
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) 年薪
FROM employees
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

#按表达式别名排序-按年薪的高低显示员工的信息和年薪
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) 年薪
FROM employees
ORDER BY 年薪 DESC;

#按函数排序-按姓名的长度显示员工的姓名和工资
SELECT LENGTH(first_name) 字节长度, first_name, salary
FROM employees
ORDER BY LENGTH(first_name) DESC;

#按照多个字段排序-查询员工信息，要求先按工资升序，再按员工编号降序
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;

#工资不在20000到40000之间的员工姓名和工资，按工资降序。
SELECT first_name, salary
FROM employees
WHERE salary not BETWEEN 20000 AND 40000
ORDER BY salary DESC;

#查询邮箱中包含pku的员工信息，并先按邮箱的字节数降序，再按部门号升序。
SELECT *, LENGTH(email) AS 邮箱长度
FROM employees
WHERE email LIKE '%pku%'
ORDER BY LENGTH(email) DESC,
department_id
ASC;

#字符函数
#LENGTH
SELECT LENGTH('ShuwenHe');
SELECT LENGTH('何书文');
SHOW VARIABLES LIKE '%char%';

#拼接字符串
SELECT CONCAT(first_name,'_',last_name)
FROM employees;

#UPPER和LOWER函数
#将first_name小写，last_name大写，并拼接
SELECT CONCAT(LOWER(first_name),UPPER(last_name))
FROM employees;

#SUBSTR截取子串
SELECT SUBSTRING('何书文何睿轩何睿昂',7);
SELECT SUBSTRING('何书文何睿轩何睿昂',4,3);

#姓名中名首字母大写，其他字符小写然后用_拼接，显示出来
SELECT CONCAT(UPPER(SUBSTRING(first_name,1,1)),LOWER(SUBSTRING(first_name,2)))
FROM employees;

#INSTR返回子串索引
SELECT INSTR('何书文何睿轩何睿昂','何睿轩');

#TRIM移除字符串两侧的空白字符
SELECT TRIM('   何书文   ');

#TRIM移除字符串两侧的指定字符
SELECT TRIM('a' FROM 'aaa何a书a文aaa');

#TRIM移除字符串两侧的指定字符
SELECT TRIM('aa' FROM 'aaa何a书a文aaa');

#LPAD用指定的字符实现左填充指定长度
SELECT LPAD('何书文',2,"*");

#LPAD用指定的字符实现左填充指定长度
SELECT LPAD('何书文',3,"*");

#LPAD用指定的字符实现左填充指定长度
SELECT LPAD('何书文',4,"*");

#LPAD用指定的字符实现左填充指定长度
SELECT LPAD('何书文',6,"*");

#RPAD用指定的字符实现左填充指定长度
SELECT RPAD('何书文',6,"*");

#REPLACE替换
SELECT REPLACE('何书文何睿轩','何书文','何睿昂');

#1.四舍五入ROUND
SELECT ROUND(1.45);
SELECT ROUND(1.65);
SELECT ROUND(-1.45);
SELECT ROUND(-1.65);
SELECT ROUND(1.357,2);

#CEIL向正无穷取整，返回>=该参数的最小整数
SELECT CEIL(1.2);

#FLOOR向下取整
SELECT FLOOR(2.9);
SELECT FLOOR(-2.9);

#TRUNCATE保存小数点后4位
SELECT
TRUNCATE
(3.1415926,4); 

#NOW返回当前系统日期+时间
SELECT NOW();

#CURDATE返回当前日期，不包含时间
SELECT CURRENT_DATE
();
SELECT CURDATE();

#CURTIME返回当前时间，不包含日期
SELECT CURTIME();

#YEAR
SELECT YEAR(NOW());
SELECT YEAR('2020-11-15');
SELECT YEAR(hiredate)
FROM employees;
SELECT MONTH(NOW());
SELECT MONTHNAME(NOW());

#STR_TO_DATE字符串转日期
SELECT STR_TO_DATE('2020-11-15','%Y-%m-%d');

#查询入职日期为2020-11-15 15:32:57的员工信息
SELECT *
FROM employees
WHERE hiredate = '2020-11-15 15:32:57';

#查询入职日期为2020-11-15 15:32:57的员工信息
SELECT *
FROM employees
WHERE hiredate = STR_TO_DATE('11-15 2020 15:32:57','%m-%d %Y %H:%i:%s');

#查询入职日期为2020-11-15 15:32:57的员工信息
SELECT *
FROM employees
WHERE hiredate = STR_TO_DATE('11-15 2020 15:32:57','%m-%d %Y %H:%i:%s');

#DATE_FORMAT将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日');

#查询有奖金的员工名和入职日期xx月/xx日 xx年
SELECT first_name, DATE_FORMAT(hiredate,'%m/%d %y') AS 入职日期
FROM employees
WHERE commission_pct is NOT NULL;

#查询有奖金的员工名和入职日期xx月/xx日 xx年
SELECT CONCAT(first_name,last_name) AS 员工姓名, DATE_FORMAT(hiredate,'%m/%d %y') AS 入职日期
FROM employees
WHERE commission_pct is NOT NULL;

#版本函数
SELECT VERSION();

#数据库函数
SELECT DATABASE
();

#当前用户
SELECT USER
();

#流程控制
#IF函数
SELECT
IF(2>1,'大于','小于');

SELECT
IF(2<1,'大于','小于');

SELECT first_name, commission_pct, 
IF(commission_pct IS NULL,'没奖金','有奖金')
FROM employees;

#CASE函数
/*
查询员工的工资，要求
部门号=30，显示的工资为1.1倍
部门号=40，显示的工资为1.2倍
部门号=50，显示的工资为1.3倍
其他部门，显示的工资为原工资
*/
SELECT salary 原始工资, department_id,
    CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新工资
FROM employees;

/*
查询员工的工资情况
如果工资>50000，显示A级别
如果工资>40000，显示B级别
如果工资>30000，显示C级别
否则，显示D级别
*/
SELECT first_name, salary, CASE
WHEN salary>50000 THEN   'A'
WHEN salary>40000 THEN   'B'
WHEN salary>30000 THEN   'C'
ELSE 'D'
END AS 工资级别
FROM employees;

-- 分组函数
-- SUM计算工资之和
SELECT SUM(salary)
FROM employees;

-- AVG平均值
SELECT AVG(salary)
FROM employees;

-- MIN
SELECT MIN(salary)
FROM employees;

-- MAX
SELECT MAX(salary)
FROM employees;

-- COUNT
SELECT COUNT(salary)
FROM employees;

-- GROUP BY
-- 查询每个工种的最高工资
SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id;


-- HAVING 查询哪个部门的员工个数>2
SELECT COUNT(*), department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

-- HAVING查询每个工种有奖金的员工的最高工资>35000的工种编号和最高工资
SELECT job_id, MAX(salary)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary)>35000;

-- 查询领导编号>100的每个领导手下的最低工资>35000的领导编号是哪个，以及其最低工资
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id>100
GROUP BY manager_id
HAVING MIN(salary)>35000;

-- 查询员工姓名
select ename
from emp;

-- 查询员工的年薪
select ename, sal*12
from emp;

-- 给查询结果重命名
select ename, sal*12 as yearsal
from emp;

-- 给查询结果中文重命名
select ename, sal*12 as '年薪'
from emp;

-- 给查询结果重命名
select ename, sal*12 yearsal
from emp;

-- 查询所有字段
select *
from emp;

-- 008.条件查询
-- 查询工资等于5000的员工名
select ename, sal
from emp
where sal = 5000;
-- 查询'SMITH'的工资
select ename, sal
from emp
where ename = 'SMITH';
-- 查询工资大于2000的员工名及其工资和部门编号
select ename, sal, deptno
from emp
where sal > 2000;
-- 查询工资不等于5000的员工名及其工资
select ename, sal
from emp
where sal <>5000;
-- 查询工资不等于5000的员工名及其工资
select ename, sal
from emp
where sal !=5000;
-- 查询工资在1500到5000之间的员工名及其工资[1500,5000]
select ename, sal
from emp
where sal >1500 and sal < 5000;
select ename, sal
from emp
where sal BETWEEN 1500 and 5000;

-- 009.条件查询between and
-- 查询名字首字母在A到S之间的员工名[A,S)
select ename
from emp
where ename BETWEEN 'A' AND 'S';

-- 010.条件查询is null和is not null
-- 查询提成是NULL的员工名
SELECT ename, comm
FROM emp
WHERE comm is NULL;

-- 查询提成不是NULL的员工名
SELECT ename, comm
FROM emp
WHERE comm is NOT NULL;

-- 查询提成是NULL的员工名
SELECT ename, comm
FROM emp
WHERE comm is NULL or comm=0;

-- 012.and和or的优先级问题
-- 找出工作岗位是MANAGER和SALESMAN的员工？
SELECT ename, job
FROM emp
WHERE job = 'MANAGER' OR job = 'SALESMAN';
-- and和or联合起来用：找出薪资大于2000的并且部门编号是10或30部门的员工。
SELECT ENAME, SAL, DEPTNO
FROM emp
WHERE SAL>2000 AND (DEPTNO = 10 OR DEPTNO = 30);

-- 013.条件查询in等同于or 
-- in等同于or
-- 找出工作岗位是MANAGER和SALESMAN的员工
SELECT ename, job
FROM emp
WHERE job = "MANAGER" OR job = "SALESMAN";
-- 
SELECT ename, job
FROM emp
WHERE job in('MANAGER','SALESMAN');
-- 找出薪资是3000或5000的员工姓名及其工资
SELECT ename, sal
FROM emp
WHERE sal = 3000 or sal = 5000;
-- 
SELECT ename, sal
FROM emp
WHERE sal in(3000,5000);

-- 找出薪资不是3000或5000的员工姓名及其工资
SELECT ename, sal
FROM emp
WHERE sal not in(3000,5000);

-- 0014.模糊查询like
-- 找出名字当中含有下划线的员工？
SELECT ename
FROM emp
WHERE ename LIKE '%\_%';
-- 找出名字当中含有S的员工？
SELECT ename
FROM emp
WHERE ename LIKE '%S%';
-- 找出名字最后是H的员工姓名?
SELECT ename
FROM emp
WHERE ename LIKE '%H';
-- 0015.排序(升序、降序)
-- 查询员工工资按照升序排列？
SELECT ename, sal
FROM emp
ORDER BY sal;
-- 
SELECT ename, sal
FROM emp
ORDER BY sal ASC;

-- 查询员工工资按照降序排列？
SELECT ename, sal
FROM emp
ORDER BY sal DESC;

-- 
select ename, sal
from emp
order by 2;

-- 找出工作岗位是MANAGER的员工，并且要求按照薪资的降序排列
SELECT ename, job, sal
FROM emp
WHERE job = 'MANAGER'
ORDER BY sal DESC;

-- 017.分组函数
-- 工资之和
SELECT SUM(SAL)
FROM emp;
-- 
SELECT AVG(sal)
FROM emp;
-- 
SELECT MIN(sal)
FROM emp;
-- 
SELECT MAX(sal)
FROM emp;
-- 
SELECT COUNT(*)
FROM emp;
-- 
SELECT COUNT(ename)
FROM emp;

-- 分组函数自动忽略NULL
SELECT COUNT(comm)
FROM emp;

-- ifnull
SELECT ename, IFNULL(comm,0)
FROM emp;

-- 计算每个员工年薪
SELECT ename, (sal+ifnull(comm,0))*12 yearsal
FROM emp;

-- 018.count函数
-- 找出工资高于平均工资的员工？
SELECT ename, sal
FROM emp
WHERE SAL>AVG(SAL);

-- 
SELECT COUNT(*)
FROM emp;

-- 
SELECT COUNT(comm)
FROM emp;
-- 
SELECT COUNT(*), MAX(sal), MIN(sal), AVG(sal), SUM(sal)
FROM emp;

-- group by and having
-- 找出每个工作岗位的最高薪资
SELECT ename, job, MAX(sal)
FROM emp
GROUP BY job;

--子查询
-- 找出高于平均工资的员工
-- 平均工资
SELECT AVG(sal)
FROM emp;
-- 高于平均工资的员工
SELECT ename, sal
FROM emp
WHERE sal > 2468.333333;
-- select中包含select 
SELECT ename, sal
FROM emp
WHERE sal > (SELECT AVG(sal)
FROM emp);
-- 当一条语句中有group by时，select后面只能跟分组函数和参与分组的字段
select ename, max(sal), job
from emp
group by job;
-- 每个工作岗位的平均工资？
SELECT job, avg(sal)
FROM emp
GROUP BY job;

-- 多字段联合分组查询
-- 找出每个部门不同工作岗位的最高薪资并按照最高工资降序排列？
SELECT deptno, job, MAX(sal) maxsal
FROM emp
GROUP BY deptno,job
ORDER BY  maxsal desc;
-- 找出每个部门的最高薪资，要求显示薪资不小于3000的员工并按薪资升序排列？
SELECT ename, deptno, MAX(sal) maxsal
FROM emp
GROUP BY deptno
HAVING maxsal >=3000
ORDER BY maxsal ASC;
-- 效率高
SELECT ename, deptno, MAX(sal) maxsal
FROM emp
WHERE sal >= 3000
GROUP BY deptno
ORDER BY maxsal;
-- 找出每个部门的平均工资，要求显示平均工资大于2200的数据，并按平均工资升序排列？
SELECT deptno, AVG(sal) avgsal
FROM emp
GROUP BY deptno
HAVING avgsal > 2200
ORDER BY avgsal ASC;
-- distinct
SELECT DISTINCT job
FROM emp;
-- 查询每个部门中的工作种类，一个部门中同一个工种只保留一个？
SELECT DISTINCT deptno, job
FROM emp
ORDER BY deptno;
-- 统计岗位的数量？
SELECT COUNT(DISTINCT job)
FROM emp;
-- 找出每一个员工的部门名称，要求显示员工名和部门名？
SELECT ename, deptno
FROM emp;
-- 
SELECT dname
FROM dept;
-- 
SELECT ename, dname
FROM emp, dept;

-- 查询每一个员工的部门名称，要求显示员工名和部门名？ 
SELECT e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;
-- join on
SELECT e.ename, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno;

-- join on
SELECT e.ename, d.dname
FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;

-- 非等值连接
-- 查询每个员工的工资等级，要求显示员工名、工资、工资等级。
SELECT e.ename, e.sal, s.grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 查询每个员工的工资等级，要求显示员工名、工资、工资等级。
SELECT e.ename, e.sal, s.grade
FROM emp e INNER JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- 自连接
-- 查询每个员工的上级领导，要求显示员工名、员工号和对应的领导名、领导号
SELECT a.ename, a.empno, a.mgr, b.ename, b.empno
FROM emp a JOIN emp b ON a.mgr = b.empno;

-- 找出每个员工的员工名及上级领导名
SELECT a.ename 'emp', b.ename 'leader'
FROM emp a LEFT JOIN emp b ON a.mgr = b.empno;

-- 找出每个员工的员工名及上级领导名
SELECT a.ename 'emp', b.ename 'leader'
FROM emp b RIGHT JOIN emp a ON a.mgr = b.empno;

-- 找出哪个部门没有员工？
SELECT d.deptno
FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.deptno is NULL;

-- 查询每一个员工的员工名、部门名称及其工资等级。
SELECT e.ename, d.dname, s.grade
FROM emp e
    JOIN dept d
    ON e.deptno = d.deptno
    JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal;

-- 查询每一个员工的部门名称、工资等级、以及上级领导？ 
SELECT e.ename, e.sal, s.grade, l.ename leader
FROM emp e
    JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal
    LEFT JOIN emp l
    ON e.mgr = l.empno;

-- 子查询
-- 找出高于平均工资的员工？
SELECT e.ename, e.sal
FROM emp e
WHERE e.sal > (SELECT AVG(e2.sal)
FROM emp e2);

-- from后面嵌套子查询
-- 找出每个部门平均薪水的薪资等级？
-- 第一步：找出每个部门的平均薪资？() t
SELECT e.deptno, AVG(e.sal) asal
FROM emp e
GROUP by e.deptno
-- 第二步：与薪资等级表联合查询
SELECT deptno, t.avgsal, s.grade
FROM
    (SELECT e.deptno, AVG(e.sal) avgsal
    FROM emp e
    GROUP by e.deptno) t
    JOIN salgrade s
    ON t.avgsal BETWEEN s.losal AND s.hisal;

-- 找出每个部门平均的薪水等级？
-- First: 找出每个员工的薪水等级 () t
SELECT e.ename, e.sal, e.deptno, s.grade
FROM emp e
    JOIN salgrade s
    ON e.sal 
    BETWEEN s.losal AND s.hisal;
-- Second:基于以上结果，继续按照deptno分组，求grade平均值。
SELECT e.ename, e.sal, e.deptno, AVG(s.grade) avggrade
FROM emp e
    JOIN salgrade s
    ON e.sal 
    BETWEEN s.losal AND s.hisal
GROUP BY deptno
ORDER BY avggrade;

-- SELECT后面嵌套子查询
-- 查询每个员工所在的部门名称，要求显示员工名和部门名？

