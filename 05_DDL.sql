-- Data Definition Language (DDL)

-- What is DDL?
-- DDL (Data Definition Language) is a subset of T-SQL used to define and manage database structures.
-- Includes commands to create, modify, and delete database objects like databases, tables, schemas, and indexes.

-- Common DDL Commands
-- CREATE: Creates a new database object (e.g., database, table, view).
-- ALTER: Modifies an existing database object.
-- DROP: Deletes a database object permanently.
-- TRUNCATE: Removes all data from a table without deleting the table structure.

-- Creating a Database
-- Creates a new database with specified name and optional file settings.
CREATE DATABASE CustomerDB;

-- Creating a Table
-- Defines a table with columns, data types, and constraints.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Email NVARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE()
);

-- Creating a Schema
-- Organizes database objects into logical groups.
CREATE SCHEMA Sales;
GO

-- Creating a Table in a Schema
CREATE TABLE Sales.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2)
);

-- Altering a Table
-- Adds, modifies, or drops columns or constraints in a table.
ALTER TABLE Customers
ADD Phone VARCHAR(15);

-- Modifying a Column
ALTER TABLE Customers
ALTER COLUMN FirstName VARCHAR(100);

-- Dropping a Column
ALTER TABLE Customers
DROP COLUMN Phone;

-- Dropping a Table
-- Deletes the table and its data permanently.
DROP TABLE Sales.Orders;

-- Truncating a Table
-- Removes all rows from a table but keeps the structure.
TRUNCATE TABLE Customers;

-- Creating an Index
-- Improves query performance on frequently searched columns.
CREATE INDEX IX_Customer_Email
ON Customers (Email);

-- Dropping an Index
DROP INDEX IX_Customer_Email ON Customers;

-- Creating a View
-- Creates a virtual table based on a query.
CREATE VIEW ActiveCustomers AS
SELECT CustomerID, FirstName, Email
FROM Customers
WHERE CreatedDate >= '2025-01-01';

-- Altering a View
ALTER VIEW ActiveCustomers AS
SELECT CustomerID, FirstName, Email, CreatedDate
FROM Customers
WHERE CreatedDate >= '2025-01-01';

-- Dropping a View
DROP VIEW ActiveCustomers;

-- Best Practices
-- Use meaningful names for tables, schemas, and columns.
-- Specify constraints (e.g., PRIMARY KEY) during table creation for data integrity.
-- Be cautious with DROP and TRUNCATE as they are irreversible.
-- Use schemas to organize objects in large databases.
-- Regularly review and optimize database structure for performance.

-- Example with Multiple DDL Operations
CREATE DATABASE ShopDB;
GO
USE ShopDB;
GO
CREATE SCHEMA Inventory;
GO
CREATE TABLE Inventory.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(8,2),
    Stock INT
);
GO
ALTER TABLE Inventory.Products
ADD LastUpdated DATE;
GO
CREATE INDEX IX_ProductName
ON Inventory.Products (ProductName);
GO
INSERT INTO Inventory.Products (ProductID, ProductName, UnitPrice, Stock)
VALUES (1, 'Keyboard', 49.99, 200);
GO
TRUNCATE TABLE Inventory.Products;
GO
DROP TABLE Inventory.Products;
GO
DROP DATABASE ShopDB;