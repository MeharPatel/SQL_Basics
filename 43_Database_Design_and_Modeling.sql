-- Database Design and Modeling

-- What is Database Design and Modeling?
-- Database design defines the structure of a database, including tables, columns, and relationships.
-- Modeling involves creating a logical representation (e.g., ERD) to plan the database.

-- Key Concepts
-- Entities: Objects (e.g., Customers, Orders) represented as tables.
-- Attributes: Properties of entities (e.g., CustomerID, OrderDate).
-- Relationships: Links between entities (e.g., one-to-many).
-- Normalization: Ensures data integrity and efficiency.
-- ERD (Entity-Relationship Diagram): Visualizes database structure.

-- Creating Tables for a Simple Model
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Email VARCHAR(100)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Inserting Sample Data
INSERT INTO Customers (CustomerID, FirstName, Email)
VALUES (1, 'John', 'john@email.com'),
       (2, 'Jane', 'jane@email.com');
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES (101, 1, '2023-01-15'),
       (102, 2, '2023-02-10');

-- Querying the Model
SELECT c.FirstName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Best Practices
-- Identify entities and relationships before creating tables.
-- Use appropriate data types for attributes (e.g., INT, VARCHAR).
-- Enforce referential integrity with FOREIGN KEY constraints.
-- Create ERDs using tools like SSMS or Visio for clarity.
-- Iterate on designs to balance performance and scalability.

-- Clean Up
DROP TABLE Orders;
DROP TABLE Customers;