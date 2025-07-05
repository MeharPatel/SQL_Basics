-- Tables and Data Types

-- What is a Table?
-- A table is a database object that stores data in rows and columns, similar to a spreadsheet.
-- Each column has a specific data type defining the kind of data it can hold.

-- What are Data Types?
-- Data types specify the type of data a column can store (e.g., numbers, text, dates).
-- SQL Server provides various data types to optimize storage and performance.

-- Common SQL Server Data Types
-- Numeric:
--   INT: Integer values (e.g., 1, 100, -50).
--   DECIMAL(p,s): Fixed-point numbers with precision (p) and scale (s) (e.g., 123.45).
--   FLOAT: Floating-point numbers for large or precise calculations.
-- String:
--   VARCHAR(n): Variable-length text, up to n characters.
--   CHAR(n): Fixed-length text, exactly n characters.
--   NVARCHAR(n): Variable-length Unicode text for multilingual support.
-- Date and Time:
--   DATE: Stores dates (e.g., '2025-07-02').
--   DATETIME: Stores date and time (e.g., '2025-07-02 09:57:00').
--   TIME: Stores time only (e.g., '09:57:00').
-- Binary:
--   VARBINARY(n): Variable-length binary data (e.g., images, files).
-- Other:
--   BIT: Stores 0, 1, or NULL for boolean-like values.
--   UNIQUEIDENTIFIER: Stores globally unique identifiers (GUIDs).

-- Creating a Table
-- Use CREATE TABLE to define a table with columns and their data types.
CREATE TABLE Employees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    IsActive BIT
);

-- Inserting Data
-- Use INSERT INTO to add data to a table, matching column data types.
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, HireDate, IsActive)
VALUES (1, 'Alice', 'Smith', 75000.50, '2023-01-15', 1);

-- Querying Data
-- Use SELECT to retrieve data from a table.
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE IsActive = 1;

-- Modifying a Table
-- Use ALTER TABLE to add, modify, or drop columns.
ALTER TABLE Employees
ADD Email NVARCHAR(100);

-- Updating Data
-- Use UPDATE to modify existing data in a table.
UPDATE Employees
SET Email = 'alice.smith@company.com'
WHERE EmployeeID = 1;

-- Viewing Table Structure
-- Use sp_help to inspect table details like columns and data types.
EXEC sp_help 'Employees';

-- Dropping a Table
-- Use DROP TABLE to delete a table and its data permanently.
DROP TABLE Employees;

-- Best Practices
-- Choose appropriate data types to optimize storage and performance.
-- Use NVARCHAR for multilingual text support.
-- Avoid using deprecated data types like TEXT or NTEXT (use VARCHAR(MAX) or NVARCHAR(MAX) instead).
-- Ensure column names are descriptive and follow naming conventions.

-- Example with Multiple Data Types
CREATE TABLE Products (
    ProductID UNIQUEIDENTIFIER DEFAULT NEWID(),
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(8,2),
    StockQuantity INT,
    LastUpdated DATETIME
);

INSERT INTO Products (ProductName, UnitPrice, StockQuantity, LastUpdated)
VALUES ('Mouse', 29.99, 100, GETDATE());

SELECT ProductName, UnitPrice, StockQuantity
FROM Products
WHERE StockQuantity > 50;