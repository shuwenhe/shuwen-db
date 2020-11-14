/*
1.查询列表可以是:表中的字段、常量值、表达式、函数
2.查询结果是一个虚拟的表格
*/
USE bookstore;
#1.查询表中的单个字段
select first_name from employees;
#2.查询表中的多个字段
select first_name,last_name,email from employees;
#3.查询表中所有字段
#方式一：
SELECT * FROM employees;
#方式二：
SELECT employee_id,first_name,last_name,email,phone_number,job_id,salary,commission_pct,manager_id,department_id,hiredate FROM employees;
#4.常量查询
SELECT 100;
SELECT 'Mathematics';
