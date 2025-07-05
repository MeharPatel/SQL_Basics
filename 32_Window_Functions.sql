-- Window Functions (RANK, DENSE_RANK, ROW_NUMBER, etc.)

-- What are Window Functions?
-- Window functions perform calculations across a set of rows (window) related to the current row.
-- Return a value for each row without collapsing the result set (unlike aggregates).

-- Common Window Functions
-- ROW_NUMBER: Assigns a unique number to each row in the window.
-- RANK: Assigns a rank with gaps for ties.
-- DENSE_RANK: Assigns a rank without gaps for ties.
-- NTILE: Divides rows into a specified number of buckets.
-- SUM, AVG, MIN, MAX: Aggregates over a window.

-- Creating a Sample Table for Examples
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Amount DECIMAL(10,2)
);
INSERT INTO Sales (SaleID, ProductID, Amount)
VALUES (1, 101, 500.00),
       (2, 101, 300.00),
       (3, 102, 700.00),
       (4, 102, 700.00);

-- ROW_NUMBER
-- Assigns sequential numbers to rows.
SELECT SaleID, ProductID, Amount,
       ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY Amount) AS RowNum
FROM Sales;

-- RANK
-- Ranks rows with gaps for ties.
SELECT SaleID, ProductID, Amount,
       RANK() OVER (PARTITION BY ProductID ORDER BY Amount DESC) AS SaleRank
FROM Sales;

-- DENSE_RANK
-- Ranks rows without gaps for ties.
SELECT SaleID, ProductID, Amount,
       DENSE_RANK() OVER (PARTITION BY ProductID ORDER BY Amount DESC) AS DenseSaleRank
FROM Sales;

-- NTILE
-- Divides rows into 2 buckets.
SELECT SaleID, ProductID, Amount,
       NTILE(2) OVER (ORDER BY Amount) AS Bucket
FROM Sales;

-- Windowed Aggregate (SUM)
-- Calculates running total within each ProductID.
SELECT SaleID, ProductID, Amount,
       SUM(Amount) OVER (PARTITION BY ProductID ORDER BY SaleID) AS RunningTotal
FROM Sales;

-- Best Practices
-- Use PARTITION BY to segment windows for relevant calculations.
-- Choose appropriate ORDER BY for ordered window functions (e.g., ROW_NUMBER).
-- Optimize window functions by indexing columns in PARTITION BY and ORDER BY.
-- Use window functions instead of subqueries for better readability.
-- Test with large datasets to ensure performance.

-- Clean Up
DROP TABLE Sales;