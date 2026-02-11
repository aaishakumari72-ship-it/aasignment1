Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?

>>A Common Table Expression (CTE) is a temporary, named result set defined within a SQL query using the WITH clause. 
  It exists only during the execution of that query and can be referenced just like a regular table within the query.
  
Q2. Why are some views updatable while others are read-only? Explain with an example.

  >>Some views are updatable while others are read-only because it depends on how the view is created.
    A view is updatable when it is based on a single table and does not use complex features like joins, group by, distinct, or aggregate functions. 
    In this case, each row in the view directly matches one row in the original table, so the database knows exactly which row to update.
    For example, if a view is created using `SELECT id, name, salary FROM employees`, we can update the salary through the view because it clearly refers to one table.

    On the other hand, a view becomes read-only when it includes joins, group by, aggregate functions (like SUM or AVG), or distinct.
    In such cases, the data may come from multiple tables or represent grouped results, so the database cannot determine exactly which original row should be changed. 
	For example, if a view shows the average salary of each department using `GROUP BY`, we cannot update the average salary directly because it is calculated from many rows.
	Therefore, views are updatable only when the database can clearly map the view’s data back to a single row in one table.

Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?

>> Stored procedures offer several advantages compared to writing raw SQL queries repeatedly -
 First, they improve performance because the procedure is compiled and stored in the database, so it runs faster when executed multiple times.
 Second, they reduce code repetition since the same logic can be reused by simply calling the procedure instead of writing the same SQL again and again. This makes the code easier to maintain and update, because any change only needs to be made in one place. 
 Third, stored procedures improve security by allowing users to execute the procedure without giving them direct access to the underlying tables. 
 They also help organize complex business logic inside the database, making applications cleaner and more structured. Overall, stored procedures save time, increase efficiency, improve security, and make database management easier.
 
 Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
 
 >>Triggers in a database are special programs that automatically run when a specific event happens, such as an **INSERT, UPDATE, or DELETE** on a table. Their main purpose is to automatically enforce rules, maintain data integrity, or perform related actions without requiring manual intervention from the user or application.

For example, a trigger can be essential in maintaining an **audit log**. Suppose a company wants to track all changes made to employee salaries. A trigger can automatically insert the old and new salary values into a separate audit table whenever a salary is updated.
 This ensures that every change is recorded automatically, which is important for security and accountability.

Q5. Explain the need for data modelling and normalization when designing a database.

create database products;
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50), Price DECIMAL(10,2) );

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATE,
 FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3,3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');
 
 select * from Sales;
 select * from Products;
 Q6. Write a CTE to calculate the total revenue for each product 
 (Revenues = Price × Quantity), and return only products where  revenue > 3000.

 WITH cte AS (
SELECT p.ProductID, SUM(Price * Quantity) AS Revenue
FROM Sales s JOIN Products p ON p.ProductID = s.ProductID
GROUP BY p.ProductID
HAVING SUM(Price * Quantity) > 3000
)SELECT *
FROM cte;

Q7. Create a view named vw_CategorySummary that shows:
 Category, TotalProducts, AveragePrice
 
 CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

Q8. Create an updatable view containing ProductID, ProductName, and Price. 
 Then update the price of ProductID = 1 using the view.

CREATE VIEW vw_Product AS
SELECT ProductID, ProductName, Price
FROM Products;

UPDATE vw_Product
SET Price = 500
WHERE ProductID = 1;

Q9. Create a stored procedure that accepts a category name and returns all products belonging to that
category.

CREATE PROCEDURE GetProductsByCategory(IN cat_name VARCHAR(50))
SELECT ProductID, ProductName, Price
FROM Products
WHERE Category = cat_name;

CALL GetProductsByCategory('Electronics');

Q10. Create an AFTER DELETE trigger on the table that archives deleted product rows into a new
table . The archive should store ProductID, ProductName, Category, Price, and DeletedAt
timestamp.

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END $$

DELIMITER ;


