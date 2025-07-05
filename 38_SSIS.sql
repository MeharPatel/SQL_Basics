-- SQL Server Integration Services (SSIS)

-- What is SSIS?
-- SQL Server Integration Services (SSIS) is a platform for building data integration and workflow solutions.
-- Used for Extract, Transform, Load (ETL) processes to move and transform data between sources and destinations.

-- Key Components
-- Packages: Contain workflows, tasks, and data flows.
-- Control Flow: Manages tasks and workflow logic.
-- Data Flow: Handles data extraction, transformation, and loading.
-- Connections: Define links to data sources (e.g., SQL Server, Excel, flat files).
-- Transformations: Manipulate data (e.g., sort, merge, aggregate).

-- Example: Creating a Table for SSIS Data Flow
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Amount DECIMAL(10,2),
    SaleDate DATE
);
GO

-- Inserting Sample Data
INSERT INTO Sales (SaleID, ProductName, Amount, SaleDate)
VALUES (1, 'Laptop', 999.99, '2023-01-15'),
       (2, 'Mouse', 29.99, '2023-02-10');

-- SSIS Example (Conceptual T-SQL for Data Flow)
-- SSIS typically uses GUI, but this simulates a data flow loading data into another table.
CREATE TABLE SalesArchive (
    SaleID INT,
    ProductName VARCHAR(50),
    Amount DECIMAL(10,2),
    ArchiveDate DATE
);
GO

INSERT INTO SalesArchive (SaleID, ProductName, Amount, ArchiveDate)
SELECT SaleID, ProductName, Amount, GETDATE()
FROM Sales
WHERE SaleDate < '2023-02-01';

-- Best Practices
-- Use SSIS for complex ETL tasks involving multiple data sources.
-- Leverage logging and error handling in SSIS packages for debugging.
-- Optimize data flows by minimizing transformations and using bulk operations.
-- Store SSIS packages in the SSIS Catalog for deployment and management.
-- Test packages in development environments before production.

-- Clean Up
DROP TABLE Sales;
DROP TABLE SalesArchive;