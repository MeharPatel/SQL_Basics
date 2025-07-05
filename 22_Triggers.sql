-- Triggers

-- What is a Trigger?
-- A trigger is a special type of stored procedure that automatically executes in response to specific events (INSERT, UPDATE, DELETE).
-- Used to enforce business rules, maintain audit logs, or cascade changes.

-- Types of Triggers
-- DML Triggers: Respond to INSERT, UPDATE, or DELETE operations (AFTER or INSTEAD OF).
-- DDL Triggers: Respond to database schema changes (e.g., CREATE, ALTER, DROP).
-- Logon Triggers: Respond to SQL Server logon events.

-- Creating Sample Tables for Examples
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    StockQuantity INT
);

CREATE TABLE StockLog (
    LogID INT IDENTITY PRIMARY KEY,
    ProductID INT,
    ChangeDate DATETIME,
    OldQuantity INT,
    NewQuantity INT
);

-- Inserting Sample Data
INSERT INTO Products (ProductID, ProductName, StockQuantity)
VALUES (1, 'Laptop', 100),
       (2, 'Mouse', 200);

-- AFTER Trigger
-- Logs changes to StockQuantity after an UPDATE.
CREATE TRIGGER trg_AfterUpdateStock
ON Products
AFTER UPDATE
AS
BEGIN
    INSERT INTO StockLog (ProductID, ChangeDate, OldQuantity, NewQuantity)
    SELECT i.ProductID, GETDATE(), d.StockQuantity, i.StockQuantity
    FROM inserted i
    INNER JOIN deleted d ON i.ProductID = d.ProductID
    WHERE i.StockQuantity != d.StockQuantity;
END;

-- Testing AFTER Trigger
UPDATE Products
SET StockQuantity = 150
WHERE ProductID = 1;

-- Querying Log
SELECT * FROM StockLog;

-- INSTEAD OF Trigger
-- Prevents updates if new stock is negative.
CREATE TRIGGER trg_InsteadOfUpdateStock
ON Products
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE StockQuantity < 0)
    BEGIN
        RAISERROR ('Stock quantity cannot be negative.', 16, 1);
        RETURN;
    END
    UPDATE p
    SET StockQuantity = i.StockQuantity
    FROM Products p
    INNER JOIN inserted i ON p.ProductID = i.ProductID;
END;

-- Testing INSTEAD OF Trigger
UPDATE Products
SET StockQuantity = -10
WHERE ProductID = 2; -- Will fail due to trigger.

-- Dropping a Trigger
DROP TRIGGER trg_AfterUpdateStock;

-- Best Practices
-- Use triggers sparingly to avoid performance overhead.
-- Keep trigger logic simple and efficient.
-- Avoid recursive triggers unless necessary (controlled via RECURSIVE_TRIGGERS setting).
-- Use inserted and deleted tables to access changed data in DML triggers.
-- Document trigger purpose and logic for maintenance.

-- Clean Up
DROP TRIGGER IF EXISTS trg_InsteadOfUpdateStock;
DROP TABLE StockLog;
DROP TABLE Products;