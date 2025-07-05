-- Indexes

-- What is an Index?
-- An index is a database object that improves the speed of data retrieval operations.
-- Stores a copy of selected columns in a structured format for faster querying.

-- Types of Indexes
-- Clustered: Determines physical order of data in a table (one per table).
-- Nonclustered: Separate structure with pointers to data (multiple allowed).
-- Unique: Enforces uniqueness on indexed columns.
-- Filtered: Indexes a subset of rows based on a condition.
-- Columnstore: Optimized for analytical queries (column-based storage).

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

-- Creating a Clustered Index
-- Automatically created with PRIMARY KEY, but can be explicitly defined.
CREATE CLUSTERED INDEX IX_Orders_OrderID
ON Orders (OrderID);

-- Creating a Nonclustered Index
-- Improves queries on CustomerID.
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON Orders (CustomerID);

-- Creating a Unique Index
-- Ensures no duplicate OrderDates.
CREATE UNIQUE NONCLUSTERED INDEX IX_Orders_OrderDate
ON Orders (OrderDate);

-- Creating a Filtered Index
-- Indexes only orders with TotalAmount > 400.
CREATE NONCLUSTERED INDEX IX_Orders_HighValue
ON Orders (TotalAmount)
WHERE TotalAmount > 400;

-- Querying with Indexes
-- Benefits from index on CustomerID.
SELECT OrderID, OrderDate, TotalAmount
FROM Orders
WHERE CustomerID = 101;

-- Dropping an Index
DROP INDEX IX_Orders_CustomerID ON Orders;

-- Viewing Indexes
-- Displays index information for a table.
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('Orders');

-- Best Practices
-- Create indexes on frequently queried or filtered columns.
-- Avoid too many indexes to reduce maintenance overhead and storage.
-- Use unique indexes to enforce data integrity.
-- Consider filtered indexes for specific query patterns.
-- Monitor index usage with sys.dm_db_index_usage_stats.

-- Clean Up
DROP TABLE Orders;