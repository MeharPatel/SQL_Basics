-- Partitioning

-- What is Partitioning?
-- Partitioning divides large tables or indexes into smaller, manageable pieces (partitions).
-- Improves query performance and maintenance for large datasets.

-- Key Components
-- Partition Function: Defines how data is divided (e.g., by range).
-- Partition Scheme: Maps partitions to filegroups.
-- Types: Range partitioning (left or right) is most common.

-- Creating a Sample Table for Partitioning
CREATE DATABASE SalesDB;
GO
USE SalesDB;
GO
CREATE TABLE Sales (
    SaleID INT,
    SaleDate DATE,
    Amount DECIMAL(10,2)
);
GO

-- Creating Partition Function
CREATE PARTITION FUNCTION PF_SalesByDate (DATE)
AS RANGE RIGHT FOR VALUES ('2023-01-01', '2023-07-01', '2024-01-01');
GO

-- Creating Partition Scheme
CREATE PARTITION SCHEME PS_SalesByDate
AS PARTITION PF_SalesByDate
TO (FG1, FG2, FG3, FG4);
GO

-- Creating Partitioned Table
CREATE TABLE Sales (
    SaleID INT,
    SaleDate DATE,
    Amount DECIMAL(10,2),
    CONSTRAINT PK_Sales PRIMARY KEY (SaleID, SaleDate)
) ON PS_SalesByDate(SaleDate);
GO

-- Inserting Sample Data
INSERT INTO Sales (SaleID, SaleDate, Amount)
VALUES (1, '2022-12-01', 500.00),
       (2, '2023-06-15', 300.00),
       (3, '2023-12-10', 700.00);

-- Querying Partitioned Table
SELECT $PARTITION.PF_SalesByDate(SaleDate) AS PartitionNumber, *
FROM Sales;

-- Best Practices
-- Partition large tables (>1M rows) for performance benefits.
-- Align partitions with common query patterns (e.g., date ranges).
-- Use multiple filegroups for better I/O performance.
-- Monitor partition maintenance tasks (e.g., splitting, merging).
-- Test partitioning impact on queries before production.

-- Clean Up
DROP TABLE Sales;
DROP PARTITION SCHEME PS_SalesByDate;
DROP PARTITION FUNCTION PF_SalesByDate;
DROP DATABASE SalesDB;