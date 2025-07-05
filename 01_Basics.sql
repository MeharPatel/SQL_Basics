-- ### SQL Server Basics

-- **What is SQL Server?**
-- - Microsoft SQL Server is a relational database management system (RDBMS) for storing, managing, and retrieving data.
-- - Uses Transact-SQL (T-SQL), Microsoft’s SQL extension, for querying and managing databases.

-- **Key Components**
-- - **Database Engine**: Manages storage, processing, and security of data.
-- - **SQL Server Management Studio (SSMS)**: Graphical tool for database management and querying.
-- - **SQL Server Agent**: Automates tasks like backups and alerts.
-- - **Integration Services (SSIS)**: Handles data integration and ETL processes.
-- - **Reporting Services (SSRS)**: Creates and manages reports.
-- - **Analysis Services (SSAS)**: Supports data analysis and business intelligence.

-- **Example**: SSMS is used to create a database named "SalesDB" and write a T-SQL query to retrieve sales data.

-- **Editions of SQL Server**
-- - **Express**: Free, limited features for small applications.
-- - **Standard**: For small to medium businesses.
-- - **Enterprise**: Advanced features for large-scale applications.
-- - **Developer**: Free for development/testing, includes Enterprise features.

-- **Example**: A startup uses SQL Server Express to manage customer data, while a large corporation uses Enterprise for global operations.

-- **Key Features**
-- - Relational database with tables, rows, and columns.
-- - Ensures ACID properties (Atomicity, Consistency, Isolation, Durability) for reliable transactions.
-- - High availability with Always On Availability Groups.
-- - Security via encryption and role-based access.
-- - Scalable for small to enterprise-level applications.

-- **Example**: ACID ensures a bank transaction (e.g., transferring $100) is fully completed or rolled back if an error occurs.

-- **Basic Terminology**
-- - **Database**: Collection of data stored in tables.
-- - **Table**: Organizes data in rows and columns.
-- - **Schema**: Logical grouping of objects (e.g., tables, views).
-- - **Query**: T-SQL statement to retrieve or manipulate data.
-- - **Instance**: A single running copy of SQL Server.

-- **Example**: A database "EmployeeDB" has a schema "HR" with a table "Employees" storing employee details.

-- **How SQL Server Works**
-- - Stores data in databases accessed via T-SQL queries.
-- - Uses client-server model: clients send queries, server processes and returns results.
-- - Supports multiple databases per instance, each isolated.

-- **Example**: A web app sends a T-SQL query to SQL Server to fetch user profiles, and the server returns the results to display.

-- **Installation Basics**
-- - Download SQL Server from Microsoft’s site (e.g., Express edition).
-- - Install SSMS for managing databases.
-- - Compatible with Windows, Linux, or Docker (recent versions).

-- **Example**: Install SQL Server Express on Windows, then use SSMS to create a database "InventoryDB" for tracking products.

-- **Use Cases**
-- - Storing data for web apps, enterprise systems, or data warehouses.
-- - Generating reports for business intelligence.
-- - Supporting high-availability applications.

-- **Example**: A retail company uses SQL Server to store sales data, generate monthly reports via SSRS, and analyze trends with SSAS.

-- **Sample T-SQL Code Example**:
-- Create a database
CREATE DATABASE SalesDB;
GO

-- Use the database
USE SalesDB;
GO

-- Create a table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

-- Insert data
INSERT INTO Customers (CustomerID, FirstName, LastName)
VALUES (1, 'John', 'Doe');

-- Query data
SELECT * FROM Customers;

-- **Output**:
-- | CustomerID | FirstName | LastName |
-- |------------|-----------|----------|
-- | 1          | John      | Doe      |