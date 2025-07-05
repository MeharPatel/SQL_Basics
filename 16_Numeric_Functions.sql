-- Numeric Functions

-- What are Numeric Functions?
-- Numeric functions in T-SQL perform calculations or transformations on numeric data (e.g., INT, DECIMAL, FLOAT).
-- Used to manipulate numbers in queries for mathematical operations, rounding, or formatting.

-- Common Numeric Functions
-- ABS: Returns the absolute value of a number.
-- ROUND: Rounds a number to a specified precision.
-- CEILING: Returns the smallest integer greater than or equal to a number.
-- FLOOR: Returns the largest integer less than or equal to a number.
-- POWER: Raises a number to a specified power.
-- SQRT: Returns the square root of a number.
-- RAND: Generates a random float between 0 and 1.
-- ISNUMERIC: Checks if an expression can be converted to a numeric value.

-- Creating a Sample Table for Examples
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    StockQuantity INT
);

-- Inserting Sample Data
INSERT INTO Products (ProductID, ProductName, UnitPrice, Discount, StockQuantity)
VALUES (1, 'Laptop', 999.99, 0.10, 50),
       (2, 'Mouse', 29.99, 0.05, 200),
       (3, 'Keyboard', 59.99, 0.15, 150),
       (4, 'Monitor', -299.99, 0.00, 75);

-- ABS: Absolute Value
-- Returns the non-negative value of a number.
SELECT ProductName, UnitPrice, ABS(UnitPrice) AS AbsolutePrice
FROM Products;

-- ROUND: Rounding Numbers
-- Rounds to the specified number of decimal places.
SELECT ProductName, UnitPrice, ROUND(UnitPrice, 1) AS RoundedPrice
FROM Products;

-- CEILING: Round Up
-- Returns the smallest integer greater than or equal to the number.
SELECT ProductName, UnitPrice, CEILING(UnitPrice) AS CeilingPrice
FROM Products;

-- FLOOR: Round Down
-- Returns the largest integer less than or equal to the number.
SELECT ProductName, UnitPrice, FLOOR(UnitPrice) AS FloorPrice
FROM Products;

-- POWER: Exponentiation
-- Raises a number to a specified power.
SELECT ProductName, StockQuantity, POWER(StockQuantity, 2) AS QuantitySquared
FROM Products;

-- SQRT: Square Root
-- Returns the square root of a number.
SELECT ProductName, StockQuantity, SQRT(StockQuantity) AS SquareRootQuantity
FROM Products;

-- RAND: Random Number
-- Generates a random float between 0 and 1 (seed optional for reproducibility).
SELECT ProductName, RAND() AS RandomValue
FROM Products;

-- ISNUMERIC: Check for Numeric Value
-- Returns 1 if the expression is numeric, 0 otherwise.
SELECT ProductName, UnitPrice, ISNUMERIC(UnitPrice) AS IsPriceNumeric
FROM Products;

-- Combining Numeric Functions
-- Calculates discounted price and rounds the result.
SELECT ProductName, 
       UnitPrice, 
       Discount, 
       ROUND(UnitPrice * (1 - Discount), 2) AS DiscountedPrice
FROM Products;

-- Numeric Functions with Aggregates
-- Combines with aggregate functions like SUM or AVG.
SELECT COUNT(*) AS ProductCount,
       ROUND(AVG(UnitPrice), 2) AS AvgPrice,
       CEILING(SUM(StockQuantity)) AS TotalStockCeiling
FROM Products;

-- Best Practices
-- Use appropriate numeric data types (e.g., DECIMAL for precise values, FLOAT for approximate).
-- Avoid using numeric functions on indexed columns in WHERE clauses to maintain performance.
-- Handle negative and zero values carefully with functions like ABS or SQRT.
-- Test RAND with seeds for consistent results in development.
-- Ensure precision is specified for ROUND to avoid unexpected results.

-- Complex Example
SELECT ProductName,
       UnitPrice,
       Discount,
       ROUND(ABS(UnitPrice * (1 - Discount)), 2) AS FinalPrice,
       CEILING(SQRT(StockQuantity)) AS ApproxStockLevel
FROM Products
WHERE ISNUMERIC(UnitPrice) = 1
ORDER BY FinalPrice DESC;

-- Clean Up
DROP TABLE Products;