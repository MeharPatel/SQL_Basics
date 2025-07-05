-- ORDER BY Clause

-- What is the ORDER BY Clause?
-- The ORDER BY clause is used in T-SQL SELECT statements to sort the result set based on one or more columns.
-- Sorting can be in ascending (ASC) or descending (DESC) order.

-- Key Components
-- Used with SELECT to sort retrieved data.
-- Can sort by column names, aliases, or column positions.
-- Default sort order is ASC (ascending).
-- Can be combined with WHERE, GROUP BY, and other clauses.

-- Creating a Sample Table for Examples
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    StockQuantity INT,
    Category VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Products (ProductID, ProductName, UnitPrice, StockQuantity, Category)
VALUES (1, 'Laptop', 999.99, 50, 'Electronics'),
       (2, 'Mouse', 29.99, 200, 'Accessories'),
       (3, 'Keyboard', 59.99, 150, 'Accessories'),
       (4, 'Monitor', 299.99, 75, 'Electronics');

-- Basic ORDER BY
-- Sorts results by a single column in ascending order.
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice;

-- ORDER BY with DESC
-- Sorts results in descending order.
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC;

-- ORDER BY Multiple Columns
-- Sorts by multiple columns, prioritizing the first column.
SELECT Category, ProductName, StockQuantity
FROM Products
ORDER BY Category ASC, StockQuantity DESC;

-- ORDER BY with Column Alias
-- Sorts using a column alias defined in the SELECT clause.
SELECT ProductName, UnitPrice * StockQuantity AS TotalValue
FROM Products
ORDER BY TotalValue DESC;

-- ORDER BY with Column Position
-- Sorts by the position of the column in the SELECT list (1-based index).
SELECT ProductName, UnitPrice
FROM Products
ORDER BY 2 DESC; -- Sorts by UnitPrice (second column)

-- ORDER BY with WHERE
-- Combines sorting with filtering.
SELECT ProductName, UnitPrice, Category
FROM Products
WHERE Category = 'Electronics'
ORDER BY UnitPrice ASC;

-- ORDER BY with Aggregate Functions
-- Sorts results of grouped data.
SELECT Category, COUNT(*) AS ProductCount
FROM Products
GROUP BY Category
ORDER BY ProductCount DESC;

-- ORDER BY with NULL Values
-- NULLs are sorted first in ASC and last in DESC by default.
INSERT INTO Products (ProductID, ProductName, UnitPrice, StockQuantity, Category)
VALUES (5, 'Headphones', NULL, 100, 'Accessories');

SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice ASC;

-- Best Practices
-- Specify ASC or DESC explicitly for clarity, even though ASC is default.
-- Avoid sorting by column position (e.g., ORDER BY 2) for readability.
-- Index columns frequently used in ORDER BY to improve performance.
-- Use meaningful column names or aliases in ORDER BY clauses.
-- Be cautious with large datasets, as sorting can be resource-intensive.

-- Example with Combined Features
SELECT ProductName, UnitPrice, StockQuantity, Category
FROM Products
WHERE StockQuantity > 50
ORDER BY Category ASC, UnitPrice DESC;

-- Clean Up
DROP TABLE Products;