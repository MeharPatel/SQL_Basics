-- Normalization and Denormalization

-- What is Normalization?
-- Normalization organizes data to eliminate redundancy and ensure data integrity.
-- Involves dividing data into tables with defined relationships (e.g., 1NF, 2NF, 3NF).

-- What is Denormalization?
-- Denormalization combines tables or adds redundant data to improve query performance.
-- Trades data integrity for faster reads, often used in data warehouses.

-- Creating Normalized Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    CityID INT
);
CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(50)
);
GO

-- Inserting Sample Data (Normalized)
INSERT INTO Cities (CityID, CityName) VALUES (1, 'New York'), (2, 'Chicago');
INSERT INTO Customers (CustomerID, FirstName, CityID)
VALUES (1, 'John', 1), (2, 'Jane', 2);

-- Querying Normalized Data
SELECT c.FirstName, ci.CityName
FROM Customers c
JOIN Cities ci ON c.CityID = ci.CityID;

-- Creating Denormalized Table
CREATE TABLE CustomerDenorm (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    CityName VARCHAR(50) -- Redundant data
);
GO

-- Inserting Denormalized Data
INSERT INTO CustomerDenorm (CustomerID, FirstName, CityName)
SELECT CustomerID, FirstName, CityName
FROM Customers c
JOIN Cities ci ON c.CityID = ci.CityID;

-- Querying Denormalized Data
SELECT FirstName, CityName
FROM CustomerDenorm;

-- Best Practices
-- Normalize during database design for data integrity.
-- Denormalize selectively for read-heavy scenarios (e.g., reporting).
-- Use indexes on foreign keys in normalized tables.
-- Document normalization levels (e.g., 3NF) for maintenance.
-- Balance normalization and denormalization based on application needs.

-- Clean Up
DROP TABLE CustomerDenorm;
DROP TABLE Customers;
DROP TABLE Cities;