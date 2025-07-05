-- Query Optimization and Performance Tuning

-- What is Query Optimization?
-- Query optimization involves writing and structuring T-SQL queries to execute efficiently.
-- Performance tuning focuses on improving database and query performance using indexes, statistics, and server settings.

-- Key Techniques
-- Indexes: Improve data retrieval speed.
-- Query Structure: Write efficient SELECT statements.
-- Statistics: Help the query optimizer choose the best execution plan.
-- Execution Plans: Analyze how SQL Server processes queries.
-- Avoid Overfetching: Select only needed columns and rows.

-- Creating a Sample Table for Examples
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (1, 101, '2023-01-15', 500.00),
       (2, 102, '2023-02-10', 300.00),
       (3, 101, '2023-03-05', 700.00),
       (4, 103, '2023-04-20', 200.00);

-- Creating an Index for Optimization
-- Improves queries filtering on CustomerID.
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON Orders (CustomerID);

-- Efficient Query
-- Selects specific columns and uses indexed column in WHERE.
SELECT OrderID, OrderDate
FROM Orders
WHERE CustomerID = 101;

-- Inefficient Query (Avoid)
-- Avoids functions on indexed columns and SELECT *.
-- Bad: SELECT * FROM Orders WHERE YEAR(OrderDate) = 2023;

-- Using Execution Plans
-- View the execution plan in SSMS to identify costly operations.
SET SHOWPLAN_TEXT ON;
SELECT OrderID, TotalAmount
FROM Orders
WHERE OrderDate = '2023-01-15';
SET SHOWPLAN_TEXT OFF;

-- Updating Statistics
-- Ensures the optimizer has accurate data distribution info.
UPDATE STATISTICS Orders;

-- Avoiding Overfetching
-- Select only needed columns instead of *.
SELECT CustomerID, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID;

-- Using Query Hints
-- Forces an index for specific queries (use cautiously).
SELECT OrderID, OrderDate
FROM Orders WITH (INDEX(IX_Orders_CustomerID))
WHERE CustomerID = 101;

-- Best Practices
-- Create indexes on frequently filtered or joined columns.
-- Avoid functions on columns in WHERE or JOIN clauses to use indexes.
-- Regularly update statistics to maintain query performance.
-- Analyze execution plans to identify bottlenecks (e.g., table scans).
-- Minimize data retrieval by selecting only necessary columns and rows.

-- Clean Up
DROP INDEX IX_Orders_CustomerID ON Orders;
DROP TABLE Orders;