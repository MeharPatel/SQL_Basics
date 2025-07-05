-- SQL Server Management Studio (SSMS)

-- What is SSMS?
-- SQL Server Management Studio is a graphical interface for managing SQL Server databases.
-- Used to write and execute T-SQL queries, manage objects, and perform administrative tasks.

-- Key Features
-- Query Editor: Write and execute T-SQL scripts.
-- Object Explorer: Manage databases, tables, and other objects.
-- Reports: Generate performance and usage reports.
-- Wizards: Simplify tasks like backup, restore, and import/export.

-- Example: Creating a Database in SSMS
-- Typically done via GUI, but here’s the T-SQL equivalent.
CREATE DATABASE InventoryDB;
GO

-- Example: Creating a Table in SSMS
-- Can be done via Object Explorer or T-SQL.
USE InventoryDB;
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Stock INT
);
GO

-- Example: Querying Data
-- Use Query Editor to run this.
INSERT INTO Products (ProductID, ProductName, Stock)
VALUES (1, 'Laptop', 100),
       (2, 'Mouse', 200);
SELECT * FROM Products;

-- Example: Viewing Execution Plans
-- Enable in SSMS via Query > Include Actual Execution Plan.
SELECT ProductID, ProductName
FROM Products
WHERE Stock > 150;

-- Best Practices
-- Use SSMS templates for common tasks to save time.
-- Save T-SQL scripts for reusability and version control.
-- Use Object Explorer to verify object properties before modifications.
-- Leverage SSMS reports for performance monitoring.
-- Keep SSMS updated to access new features and security patches.

-- Clean Up
DROP TABLE Products;
DROP DATABASE InventoryDB;