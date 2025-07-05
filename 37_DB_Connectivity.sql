-- Database Connectivity (ODBC, JDBC)

-- What is Database Connectivity?
-- Database connectivity allows applications to interact with SQL Server using standard protocols.
-- ODBC (Open Database Connectivity) and JDBC (Java Database Connectivity) are common APIs.

-- Key Concepts
-- ODBC: Platform-independent API for accessing SQL Server from various applications.
-- JDBC: Java-specific API for connecting Java applications to SQL Server.
-- Connection String: Specifies server, database, and authentication details.

-- Creating a Sample Table for Examples
CREATE DATABASE SalesDB;
GO
USE SalesDB;
GO
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50)
);
GO
INSERT INTO Customers (CustomerID, FirstName)
VALUES (1, 'John'),
       (2, 'Jane');

-- Example Connection Strings (Commented as Reference)
-- ODBC Connection String Example:
-- Driver={SQL Server};Server=YourServerName;Database=SalesDB;Trusted_Connection=True;

-- JDBC Connection String Example:
-- jdbc:sqlserver://YourServerName:1433;databaseName=SalesDB;integratedSecurity=true;

-- Testing Connectivity with T-SQL
-- T-SQL itself doesn’t handle ODBC/JDBC, but here’s a query applications might run.
SELECT CustomerID, FirstName
FROM Customers
WHERE CustomerID = 1;

-- Best Practices
-- Use connection pooling to improve performance in applications.
-- Secure connection strings with encrypted credentials or integrated security.
-- Test connectivity with tools like SSMS or JDBC/ODBC test utilities.
-- Ensure SQL Server allows remote connections (configured via SQL Server Configuration Manager).
-- Use the latest ODBC/JDBC drivers for compatibility and performance.

-- Clean Up
DROP TABLE Customers;
DROP DATABASE SalesDB;