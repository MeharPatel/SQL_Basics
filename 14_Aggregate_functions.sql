-- Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

-- What are Aggregate Functions?
-- Aggregate functions perform calculations on a set of values and return a single result.
-- Commonly used with GROUP BY to summarize data across groups of rows.

-- Common Aggregate Functions
-- COUNT: Counts the number of rows or non-NULL values in a column.
-- SUM: Calculates the total of numeric values in a column.
-- AVG: Computes the average of numeric values in a column.
-- MIN: Finds the smallest value in a column.
-- MAX: Finds the largest value in a column.

-- Creating a Sample Table for Examples
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE
);

-- Inserting Sample Data
INSERT INTO Sales (SaleID, ProductID, Quantity, UnitPrice, SaleDate)
VALUES (1, 101, 5, 20.00, '2023-01-10'),
       (2, 102, 3, 15.00, '2023-01-15'),
       (3, 101, 10, 20.00, '2023-02-01'),
       (4, 103, 2, 50.00, '2023-02-10'),
       (5, 102, NULL, 15.00, '2023-03-01');

-- COUNT: Counting Rows
-- Counts all rows or non-NULL values in a column.
SELECT COUNT(*) AS TotalSales
FROM Sales;

-- COUNT with Specific Column
-- Counts non-NULL values in the Quantity column.
SELECT COUNT(Quantity) AS ValidQuantities
FROM Sales;

-- SUM: Totaling Values
-- Sums numeric values in a column.
SELECT SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Sales;

-- AVG: Calculating Average
-- Computes the average of non-NULL values.
SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;

-- MIN: Finding Minimum Value
-- Returns the smallest value in a column.
SELECT MIN(UnitPrice) AS MinUnitPrice
FROM Sales;

-- MAX: Finding Maximum Value
-- Returns the largest value in a column.
SELECT MAX(Quantity) AS MaxQuantity
FROM Sales;

-- Combining Aggregate Functions with GROUP BY
-- Groups data and applies aggregates to each group.
SELECT ProductID, 
       COUNT(*) AS SaleCount,
       SUM(Quantity) AS TotalQuantity,
       AVG(UnitPrice) AS AvgPrice
FROM Sales
GROUP BY ProductID;

-- Aggregate Functions with HAVING
-- Filters groups based on aggregate conditions.
SELECT ProductID, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY ProductID
HAVING SUM(Quantity * UnitPrice) > 100;

-- Aggregate Functions with WHERE
-- Filters rows before applying aggregates.
SELECT COUNT(*) AS RecentSales
FROM Sales
WHERE SaleDate >= '2023-02-01';

-- Combining Multiple Aggregates
-- Uses multiple aggregate functions in one query.
SELECT ProductID,
       COUNT(*) AS SaleCount,
       SUM(Quantity * UnitPrice) AS TotalRevenue,
       MIN(SaleDate) AS FirstSale,
       MAX(SaleDate) AS LastSale
FROM Sales
GROUP BY ProductID
ORDER BY TotalRevenue DESC;

-- Best Practices
-- Use COUNT(1) or COUNT(*) for row counts, not COUNT(column) unless excluding NULLs.
-- Ensure columns in SELECT are either in GROUP BY or aggregated.
-- Index columns used in WHERE or GROUP BY to improve performance.
-- Handle NULL values appropriately, as they are ignored by SUM, AVG, MIN, and MAX.
-- Test aggregate queries on large datasets to ensure efficiency.

-- Clean Up
DROP TABLE Sales;