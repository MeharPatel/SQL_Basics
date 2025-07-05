-- SQL Injection and Security Best Practices

-- What is SQL Injection?
-- SQL Injection is a security vulnerability where malicious SQL code is inserted into input fields to manipulate queries.
-- Can lead to unauthorized data access, modification, or deletion.

-- Security Best Practices
-- Use Parameterized Queries: Prevent direct input in SQL statements.
-- Avoid Dynamic SQL: Use stored procedures or parameterized queries instead.
-- Restrict Permissions: Apply principle of least privilege.
-- Validate Input: Sanitize user inputs on the application side.
-- Use Prepared Statements: Supported in application frameworks (e.g., .NET, Java).

-- Creating a Sample Table for Examples
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(50)
);
GO

-- Inserting Sample Data
INSERT INTO Users (UserID, Username, Password)
VALUES (1, 'john', 'pass123'),
       (2, 'jane', 'pass456');

-- Vulnerable Query (SQL Injection Risk)
-- Avoid this: concatenating user input directly.
DECLARE @Username VARCHAR(50) = 'john''; DROP TABLE Users; --';
-- Unsafe dynamic SQL (for demonstration only, do not use):
-- EXEC ('SELECT * FROM Users WHERE Username = ''' + @Username + '''');

-- Secure Query with Parameters
-- Uses parameterized query to prevent injection.
DECLARE @SafeUsername VARCHAR(50) = 'john';
SELECT * FROM Users
WHERE Username = @SafeUsername;

-- Stored Procedure to Prevent SQL Injection
CREATE PROCEDURE GetUser
    @Username VARCHAR(50)
AS
BEGIN
    SELECT UserID, Username
    FROM Users
    WHERE Username = @Username;
END;
GO

EXEC GetUser @Username = 'jane';

-- Best Practices
-- Always use parameterized queries or stored procedures for user inputs.
-- Limit database user permissions to only necessary actions.
-- Enable SQL Server auditing to track suspicious activities.
-- Use firewalls and network security to protect SQL Server instances.
-- Regularly update SQL Server with security patches.

-- Clean Up
DROP PROCEDURE GetUser;
DROP TABLE Users;