create database Employee;
use Employee;
create table Employee(
emp_id int,
name varchar(50),
department_id varchar(50),
salary int);

insert into Employee(emp_id,name,department_id,salary)
values (101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);

create table Department(
department_id int,
department_name varchar(50),
location varchar(50));

alter table Department
modify column department_id varchar(50);

insert into Department(department_id,department_name ,location )
values
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Delhi'),
('D04','HR','Bengaluru'),
('D05','IT','Hyyderabad');

create table Sales (
sale_id varchar(50),
emp_id int ,
sale_amount int ,
sale_date date ) ;
insert into Sales (sale_id,emp_id,sale_amount,sale_date)
value 
(201,'101','4500','2025-01-05'),
(202,'102','7800','2025-01-10'),
(203,'103','6700','2025-01-14'),
(204,'104','12000','2025-01-20'),
(205,'105','9800','2025-02-02'),
(206,'106','10500','2025-02-05'),
(207,'107','3200','2025-02-09'),
(208,'108','5100','2025-02-15'),
(209,'109','3900','2025-02-20'),
(210,'110','7200','2025-03-01');

Basic Level

1.Retrieve the names of employees who earn more than the average salary of all employees.

select name
from Employee 
where salary>( select avg(salary)
from Employee);

2.Find the employees who belong to the department with the highest average salary.

SELECT *
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

3. List all employees who have made at least one sale.

select distinct e.name 
from employee e join Sales s on e.emp_id =s.emp_id;

4..Find the employee with the highest sale amount

select e.name,s.sale_amount
from employee e join Sales s on e.emp_id = s.emp_id 
order by s.sale_amount desc
limit 1;

5.Retrieve the names of employees whose salaries are higher than Shubham’s salary

select name ,salary from employee
where salary >58000 ;

Intermediate Level

1. Find employees who work in the same department as Abhishek.

select *from Employee
where department_id = 'D01';

2.List departments that have at least one employee earning more than ₹60,000

select e.department_id,d.department_name,e.salary
from Employee e join Department d on e.department_id = d.department_id
 where e.salary >60000;

3. Find the department name of the employee who made the highest sale.

select d.department_name , s.sale_amount
from Employee e join Sales s on e.emp_id = s.emp_id
join Department d on d.department_id = e.department_id
order by s.sale_amount desc
limit 1;

4. Retrieve employees who have made sales greater than the average sale amount.

select e.name,avg(s.sale_amount) as sales
from Employee e join Sales s on e.emp_id = s.emp_id
where s.sale_amount > (select avg(sale_amount) from Sales)
 group by e.name;
 
 5.Find the total sales made by employees who earn more than the average salary.
 
 select e.name,s.sale_amount
 from Employee e join Sales s on e.emp_id = s.emp_id
 where e.salary>(Select avg(salary) from Employee)
 ;
 
 Advanced Level

1. Find employees who have not made any sales.

SELECT e.emp_id, e.name
FROM Employee e
LEFT JOIN Sales s ON e.emp_id = s.emp_id
WHERE s.emp_id IS NULL;

2.List departments where the average salary is above ₹55,000

select d.department_name 
from Department d join Employee e on e.department_id =d.department_id 
where e.salary >(select avg(salary) from Employee);

3.Retrieve department names where the total sales exceed ₹10,000.
select d.department_name 
from Department d join Employee e on e.department_id = d.department_id
join Sales s on e.emp_id = s.emp_id 
where s.sale_amount > 10000;

4.Find the employee who has made the second-highest sale.

SELECT e.name, s.sale_amount
FROM Employee e JOIN Sales s ON e.emp_id = s.emp_id
ORDER BY s.sale_amount DESC
LIMIT 1 OFFSET 1;

5.Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
SELECT name, salary
FROM Employee
WHERE salary > (
SELECT MAX(sale_amount)
FROM Sales);
