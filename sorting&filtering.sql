/*create database aaisha;*/

/*use aaisha;
create table Employees(
EmpID int primary key,
EmpName varchar(50),
Department varchar(50),
City varchar(50),
Salary int,
HireDate date);*/

/*insert into Employees(EmpID,EmpName,Department,City,Salary,HireDate)
values
(101,'Rahul Mehata','Sales','Delhi',55000,'2020-04-12'),
(102,'Priya Sharma','HR','Mumbai',62000,'2019-09-25'),
(103,'Aman Singh','IT','Bengaluru',72000,'2021-03-10'),
(104,'Neha Patel','Sales','Delhi',48000,'2022-01-14'),
(105,'Karan Joshi','Marketing','Pune',45000,'2018-07-22'),
(106,'Divay Nair','IT','Chennai',81000,'2019-12-11'),
(107,'Raj Kumar','HR','Delhi',60000,'2020-05-28'),
(108,'Simran Kaur','Finance','Mumbai',58000,'2021-08-03'),
(109,'Arjun Reddy','IT','Hyderabad',70000,'2022-02-18'),
(110,'Anjali Das','Sales','kolkata',51000,'2023-01-15');

select*from Employees;*/
/* Question 1 :  Show employees working in either the ‘IT’ or ‘HR’ departments.*/
use aaisha;
select * from Employees
where department ='sales' or department= 'IT';

/*Question 2 : Retrieve employees whose department is in ‘Sales’, ‘IT’, or ‘Finance’.*/
select * from Employees
where department ='sales' or department= 'IT' or department='Finance';

/*Question 3 : Display employees whose salary is between ₹50,000 and ₹70,000*/
select *from Employees
where salary between 50000 AND 70000;

/*Question 4 : List employees whose names start with the letter ‘A’.*/

select EmpName from Employees
where EmpName like 'A%';

/*Question 5 : Find employees whose names contain the substring ‘an'.*/
select EmpName from Employees
where EmpName like '%an%';

/*Question 6 : Show employees who are from ‘Delhi’ or ‘Mumbai’ and earn more than ₹55,000.*/
SELECT *FROM Employees
WHERE City IN ('Delhi', 'Mumbai')
AND salary > 55000;

/*Question 7 : Display all employees except those from the ‘HR’ department.*/
select *from Employees
WHERE Department NOT IN ('HR');

/*Question 8 : Get all employees hired between 2019 and 2022, ordered by HireDate (oldest first).*/
select * from employees 
where HireDate between '2019-01-01' and '2022-12-30'
 order by HireDate desc;













