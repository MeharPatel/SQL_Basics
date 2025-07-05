-- Intelligent Query Processing

-- What is Intelligent Query Processing (IQP)?
-- IQP is a set of SQL Server features (introduced in SQL Server 2019) that improve query performance automatically.
-- Enhances query execution without changing T-SQL code.

-- Key IQP Features
-- Adaptive Joins: Dynamically chooses between join types (e.g., nested loop, hash join) based on data size.
-- Memory Grant Feedback: Adjusts memory allocation for queries to avoid spills or underuse.
-- Table Variable Deferred Compilation: Compiles table variable queries with accurate cardinality estimates.
-- Scalar UDF Inlining: Executes user-defined scalar functions inline for better performance.
-- Approximate COUNT DISTINCT: Uses approximate algorithms for faster COUNT(DISTINCT) operations.

-- Creating a Sample Table for Examples
CREATE DATABASE SalesDB;
GO
USE SalesDB;
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Amount DECIMAL(10,2)
);
INSERT INTO Orders (OrderID, CustomerID, Amount)
VALUES (1, 101, 500.00),
       (2, 102, 300.00),
       (3, 101, 700.00);

-- Adaptive Join Example
-- SQL Server dynamically selects the best join type.
SELECT o.OrderID, c.FirstName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- Table Variable Deferred Compilation
-- Improves performance of table variables.
DECLARE @TempOrders TABLE (OrderID INT, Amount DECIMAL(10,2));
INSERT INTO @TempOrders
SELECT OrderID, Amount
FROM Orders
WHERE Amount > 400;
SELECT * FROM @TempOrders;

-- Scalar UDF Inlining Example
CREATE FUNCTION dbo.CalculateTax(@Amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Amount * 0.1;
END;
GO
SELECT OrderID, dbo.CalculateTax(Amount) AS Tax
FROM Orders;

-- Best Practices
-- Enable compatibility level 150 or higher for IQP features (ALTER DATABASE SalesDB SET COMPATIBILITY_LEVEL = 150).
-- Monitor query performance to confirm IQP improvements.
-- Test queries with large datasets to leverage adaptive joins.
-- Avoid overuse of scalar UDFs, even with inlining, for complex logic.
-- Use Query Store to analyze IQP's impact on query plans.

-- Clean Up
USE master;
DROP DATABASE SalesDB;