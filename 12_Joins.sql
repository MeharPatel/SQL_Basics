-- Joins (Inner, Left, Right, Full, Self)

-- What are Joins?
-- Joins combine rows from two or more tables based on a related column.
-- Used in T-SQL SELECT statements to retrieve data from multiple tables.

-- Types of Joins
-- INNER JOIN: Returns only matching rows from both tables.
-- LEFT JOIN (LEFT OUTER JOIN): Returns all rows from the left table and matching rows from the right table; non-matching rows get NULL.
-- RIGHT JOIN (RIGHT OUTER JOIN): Returns all rows from the right table and matching rows from the left table; non-matching rows get NULL.
-- FULL JOIN (FULL OUTER JOIN): Returns all rows from both tables; non-matching rows get NULL.
-- SELF JOIN: Joins a table to itself to compare rows within the same table.

-- Creating Sample Tables for Examples
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Customers (CustomerID, FirstName, City)
VALUES (1, 'John', 'New York'),
       (2, 'Jane', 'Chicago'),
       (3, 'Alice', 'Boston');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount)
VALUES (101, 1, '2023-01-15', 500.00),
       (102, 2, '2023-02-10', 300.00),
       (103, 1, '2023-03-05', 700.00);

-- INNER JOIN
-- Returns only rows where there is a match in both tables.
SELECT c.FirstName, c.City, o.OrderID, o.Amount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- LEFT JOIN
-- Returns all rows from Customers and matching rows from Orders; non-matching Orders rows get NULL.
SELECT c.FirstName, c.City, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- RIGHT JOIN
-- Returns all rows from Orders and matching rows from Customers; non-matching Customers rows get NULL.
SELECT c.FirstName, c.City, o.OrderID, o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- FULL JOIN
-- Returns all rows from both tables; non-matching rows get NULL.
SELECT c.FirstName, c.City, o.OrderID, o.Amount
FROM Customers c
FULL JOIN Orders o ON c.CustomerID = o.CustomerID;

-- SELF JOIN
-- Joins a table to itself to compare rows (e.g., finding customers in the same city).
SELECT a.FirstName AS Customer1, b.FirstName AS Customer2, a.City
FROM Customers a
INNER JOIN Customers b ON a.City = b.City AND a.CustomerID < b.CustomerID;

-- Multiple Table Joins
-- Joins more than two tables.
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductName VARCHAR(50),
    Quantity INT
);

INSERT INTO OrderDetails (OrderID, ProductName, Quantity)
VALUES (101, 'Laptop', 2),
       (102, 'Mouse', 5);

SELECT c.FirstName, o.OrderID, od.ProductName, od.Quantity
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID;

-- Best Practices
-- Use table aliases (e.g., c, o) for readability and shorter syntax.
-- Specify join conditions clearly in the ON clause.
-- Use INNER JOIN for strict matches; use OUTER JOINs (LEFT, RIGHT, FULL) when including non-matching rows.
-- Index columns used in ON clauses to improve performance.
-- Test joins with small datasets to ensure correct results.

-- Clean Up
DROP TABLE OrderDetails;
DROP TABLE Orders;
DROP TABLE Customers;