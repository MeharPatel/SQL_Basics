-- Error Handling (TRY-CATCH)

-- What is Error Handling?
-- Error handling in T-SQL manages exceptions during query execution to prevent failures and maintain data integrity.
-- Uses TRY...CATCH blocks to capture and handle errors gracefully.

-- Key Components
-- BEGIN TRY: Contains code that might cause an error.
-- BEGIN CATCH: Handles the error with custom logic.
-- Error Functions: ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), etc., provide error details.
-- THROW: Raises custom or re-throws errors.

-- Creating a Sample Table for Examples
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    StockQuantity INT
);

-- Inserting Sample Data
INSERT INTO Products (ProductID, ProductName, StockQuantity)
VALUES (1, 'Laptop', 100),
       (2, 'Mouse', 200);

-- Basic TRY-CATCH
-- Handles a duplicate PRIMARY KEY error.
BEGIN TRY
    INSERT INTO Products (ProductID, ProductName, StockQuantity)
    VALUES (1, 'Keyboard', 150); -- Duplicate key error
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- TRY-CATCH with Transaction
-- Ensures data consistency during updates.
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE Products
    SET StockQuantity = StockQuantity - 50
    WHERE ProductID = 1;
    IF (SELECT StockQuantity FROM Products WHERE ProductID = 1) < 0
        THROW 50001, 'Stock cannot be negative.', 1;
    UPDATE Products
    SET StockQuantity = StockQuantity + 50
    WHERE ProductID = 2;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_LINE() AS ErrorLine;
END CATCH;

-- THROW for Custom Errors
-- Raises a custom error for invalid input.
BEGIN TRY
    DECLARE @Stock INT = -10;
    IF @Stock < 0
        THROW 50002, 'Stock quantity must be non-negative.', 1;
    INSERT INTO Products (ProductID, ProductName, StockQuantity)
    VALUES (3, 'Monitor', @Stock);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- Best Practices
-- Always use TRY-CATCH with transactions to prevent partial updates.
-- Log error details (e.g., ERROR_MESSAGE()) for debugging.
-- Use THROW for custom errors with meaningful messages.
-- Avoid overly broad TRY blocks; isolate risky operations.
-- Test error handling with edge cases (e.g., invalid data, duplicates).

-- Clean Up
DROP TABLE Products;