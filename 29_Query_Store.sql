-- Query Store

-- What is Query Store?
-- Query Store is a SQL Server feature (introduced in SQL Server 2016) that captures query performance data.
-- Tracks query execution plans, runtime statistics, and performance metrics for troubleshooting and optimization.

-- Key Features
-- Stores query text, execution plans, and performance metrics.
-- Helps identify performance regressions or poorly performing queries.
-- Enabled at the database level.

-- Creating a Sample Database for Examples
CREATE DATABASE InventoryDB;
GO
USE InventoryDB;
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Stock INT
);
INSERT INTO Products (ProductID, ProductName, Stock)
VALUES (1, 'Laptop', 100),
       (2, 'Mouse', 200);

-- Enabling Query Store
ALTER DATABASE InventoryDB
SET QUERY_STORE = ON (
    OPERATION_MODE = READ_WRITE,
    DATAწ

-- Querying with Query Store
-- Captures performance data for a specific query.
SELECT query_id, query_text, execution_count, total_execution_time_ms
FROM sys.query_store_query
WHERE query_id = (SELECT TOP 1 query_id FROM sys.query_store_query);

-- Forcing a Query Plan
-- Forces a specific execution plan for a query.
DECLARE @QueryID INT = (SELECT query_id FROM sys.query_store_query WHERE query_text LIKE '%SELECT ProductID, ProductName%');
EXEC sp_query_store_force_plan @QueryID;

-- Best Practices
-- Enable Query Store for critical databases to monitor performance.
-- Set appropriate data retention settings to manage storage.
-- Use Query Store to analyze query regressions after upgrades.
-- Regularly review top resource-consuming queries.
-- Use SSMS Query Store reports for easier analysis.

-- Clean Up
USE master;
DROP DATABASE InventoryDB;