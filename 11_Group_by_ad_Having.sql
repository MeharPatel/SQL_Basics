-- GROUP BY and HAVING Clauses

-- What is GROUP BY?
-- The GROUP BY clause is used in T-SQL SELECT statements to group rows with identical values in specified columns into summary rows.
-- Often used with aggregate functions (e.g., COUNT, SUM, AVG, MIN, MAX) to perform calculations on each group.

-- What is HAVING?
-- The HAVING clause filters groups created by GROUP BY based on a condition.
-- Similar to WHERE, but applied after grouping, typically with aggregate functions.

-- Key Components
-- GROUP BY: Organizes rows into groups based on one or more columns.
-- HAVING: Filters groups based on aggregate conditions.
-- Used with SELECT, FROM, and optionally WHERE and ORDER BY.

-- Creating a Sample Table for Examples
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Region VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Region)
VALUES (1, 101, '2023-01-15', 500.00, 'North'),
       (2, 102, '2023-02-10', 300.00, 'South'),
       (3, 101, '2023-03-05', 700.00, 'North'),
       (4, 103, '2023-04-20', 200.00, 'South'),
       (5, 102, '2023-05-12', 400.00, 'South');

-- Basic GROUP BY
-- Groups rows by a column and applies an aggregate function.
SELECT Region, COUNT(*) AS OrderCount
FROM Orders
GROUP BY Region;

-- GROUP BY with Multiple Columns
-- Groups by multiple columns for more detailed aggregation.
SELECT CustomerID, Region, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID, Region;

-- GROUP BY with Aggregate Functions
-- Uses multiple aggregates for comprehensive summaries.
SELECT Region, 
       COUNT(*) AS OrderCount,
       SUM(TotalAmount) AS TotalSales,
       AVG(TotalAmount) AS AvgOrderValue
FROM Orders
GROUP BY Region;

-- HAVING Clause
-- Filters groups based on an aggregate condition.
SELECT Region, COUNT(*) AS OrderCount
FROM Orders
GROUP BY Region
HAVING COUNT(*) > 2;

-- HAVING with Multiple Conditions
-- Applies multiple conditions to filter groups.
SELECT CustomerID, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 500 AND COUNT(*) >= 2;

-- GROUP BY with WHERE
-- Filters rows before grouping.
SELECT Region, AVG(TotalAmount) AS AvgOrderValue
FROM Orders
WHERE OrderDate >= '2023-03-01'
GROUP BY Region;

-- GROUP BY with ORDER BY
-- Sorts grouped results for better presentation.
SELECT Region, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY Region
ORDER BY TotalSales DESC;

-- Complex Example with GROUP BY and HAVING
-- Combines filtering, grouping, and sorting.
SELECT CustomerID, Region, COUNT(*) AS OrderCount, SUM(TotalAmount) AS TotalSales
FROM Orders
WHERE OrderDate < '2023-06-01'
GROUP BY CustomerID, Region
HAVING SUM(TotalAmount) > 400
ORDER BY TotalSales DESC;

-- Best Practices
-- Use GROUP BY only with columns in the SELECT list or aggregate functions.
-- Ensure HAVING conditions reference aggregate functions or grouped columns.
-- Index columns used in GROUP BY and WHERE for better performance.
-- Avoid unnecessary columns in GROUP BY to reduce processing overhead.
-- Test complex GROUP BY queries on small datasets to verify results.

-- Clean Up
DROP TABLE Orders;