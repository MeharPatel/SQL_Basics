-- Transactions and Concurrency

-- What are Transactions?
-- A transaction is a sequence of operations treated as a single unit of work.
-- Ensures data consistency with ACID properties: Atomicity, Consistency, Isolation, Durability.

-- What is Concurrency?
-- Concurrency manages multiple transactions accessing the same data simultaneously.
-- SQL Server uses locking and isolation levels to control concurrency.

-- Key Concepts
-- BEGIN TRANSACTION: Starts a transaction.
-- COMMIT TRANSACTION: Saves changes.
-- ROLLBACK TRANSACTION: Undoes changes.
-- Isolation Levels: Control how transactions interact (e.g., READ COMMITTED, SERIALIZABLE).
-- Locks: Prevent data conflicts (e.g., Shared, Exclusive).

-- Creating a Sample Table for Examples
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Accounts (AccountID, AccountHolder, Balance)
VALUES (1, 'John', 1000.00),
       (2, 'Jane', 500.00);

-- Basic Transaction
-- Transfers money between accounts with rollback on error.
BEGIN TRANSACTION;
UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;
UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;
IF @@ERROR = 0
    COMMIT TRANSACTION;
ELSE
    ROLLBACK TRANSACTION;

-- Explicit Transaction with Error Handling
BEGIN TRY
    BEGIN TRANSACTION;
    UPDATE Accounts
    SET Balance = Balance - 200
    WHERE AccountID = 1;
    -- Simulate an error
    IF (SELECT Balance FROM Accounts WHERE AccountID = 1) < 0
        THROW 50001, 'Insufficient funds.', 1;
    UPDATE Accounts
    SET Balance = Balance + 200
    WHERE AccountID = 2;
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

-- Setting Isolation Level
-- Prevents dirty reads during a transaction.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
SELECT AccountHolder, Balance
FROM Accounts
WHERE AccountID = 1;
-- Other transactions cannot modify this data until commit.
COMMIT TRANSACTION;

-- Best Practices
-- Keep transactions short to minimize locking and improve concurrency.
-- Use appropriate isolation levels based on application needs.
-- Always include error handling to avoid partial commits.
-- Monitor deadlocks using SQL Server Profiler or DMVs (e.g., sys.dm_tran_locks).
-- Test transactions with concurrent users to ensure reliability.

-- Clean Up
DROP TABLE Accounts;