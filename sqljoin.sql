create database sqljoin;
use sqljoin;
create table customers(
customerID int primary key,
customerName varchar(50),
city varchar(50));

insert into customers(customerID,customerName,City)
values
(1,'John Smith','New York'),
(2,'Mary Johnson','Chicago'),
(3,'Peter Adams','Los Angeles'),
(4,'Nancy Miller','Houston'),
(5,'Robert White','Miami');

create table orders(
orderID int,
customerID INT,
orderDate date,
Amount int );



insert into orders(orderID,customerID,orderDate,Amount)
values
(101,1,'2024-10-01',250),
(102,2,'2024-10-05',300),
(103,1,'2024-10-07',150),
(104,3,'2024-10-10',450),
(105,6,'2024-10-12',400);


create table payments(
paymentID varcharacter(50),
customerID int,
PaymentDate date,
Amount int);

insert into payments( paymentID,customerID,paymentDate,Amount)
values
('P001',1,'2024-10-02',250),
('P002',2,'2024-10-06',300),
('P003',3,'2024-10-11',450),
('P004',4,'2024-10-15',200);


Question 1. Retrieve all customers who have placed at least one order.
select distinct customerID from orders;

Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

select c.customerID,c.customerName,o.orderID,o.orderDate,o.Amount
from customers c left join orders o on c.customerID = o.customerID;

Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown
customers.
select c.customerID,c.customerName,o.orderID
from orders o left join customers c on c.customerID = o.customerID;

Question 4. Display all customers and orders, whether matched or not.

SELECT c.customerID,c.customerName,c.city,o.orderID,o.orderDate,o.amount
FROM customers c LEFT JOIN orders o ON c.customerID = o.customerID
UNION
SELECT c.customerID, c.customerName, c.city, o.orderID, o.orderDate, o.amount
FROM orders o LEFT JOIN customers c ON c.customerID = o.customerID
WHERE c.customerID IS NULL;

Question 5. Find customers who have not placed any orders.

SELECT c.customerID,c.customerName,c.city
FROM customers c
WHERE NOT EXISTS 
(SELECT 1 FROM orders o where o.customerID = c.customerID);

Question 6. Retrieve customers who made payments but did not place any order

select p.customerID,p.paymentID, p.amount
from orders o right join payments p on o.customerID = p.customerID
where o.customerID IS NULL;

Question 7. Generate a list of all possible combinations between Customers and Orders.

select c.customerID,c.customerName,c.city,o.orderID,o.orderDate,o.Amount
from customers c join orders o on c.customerID = o.customerID;

Question 8. Show all customers along with order and payment amounts in one table.

SELECT  c.customerID,c.customerName,c.city,o.orderID,o.orderDate,o.Amount AS 'OrderAmount',
p.paymentID,p.Amount AS PaymentAmount
FROM customers c LEFT JOIN orders o ON c.customerID = o.customerID
LEFT JOIN payments p ON o.customerID = p.customerID
ORDER BY c.customerID, o.customerID;

Question 9. Retrieve all customers who have both placed orders and made payments

select c.customerID,c.customerName,c.city,o.orderID,o.orderDate,p.paymentID,p.Amount AS 'Total Payment'
from customers c inner join orders o on c.customerID = o.customerID
inner join payments p on o.customerID = p.customerID;

