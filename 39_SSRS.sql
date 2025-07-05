-- SQL Server Reporting Services (SSRS)

-- What is SSRS?
-- SQL Server Reporting Services (SSRS) is a server-based reporting platform for creating, managing, and delivering reports.
-- Supports tabular, matrix, chart, and interactive reports.

-- Key Features
-- Report Designer: Create reports in Visual Studio (Report Builder or SSDT).
-- Report Server: Hosts and delivers reports via web or email.
-- Data Sources: Connect to SQL Server, Excel, or other databases.
-- Parameters: Allow dynamic filtering in reports.
-- Export Options: PDF, Excel, Word, etc.

-- Example: Creating a Table for Reporting
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Region VARCHAR(50),
    Amount DECIMAL(10,2),
    SaleDate DATE
);
GO

-- Inserting Sample Data
INSERT INTO Sales (SaleID, Region, Amount, SaleDate)
VALUES (1, 'North', 500.00, '2023-01-15'),
       (2, 'South', 300.00, '2023-02-10'),
       (3, 'North', 700.00, '2023-03-05');

-- T-SQL Query for SSRS Report
-- Summarizes sales by region (used in SSRS dataset).
SELECT Region, COUNT(*) AS SaleCount, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY Region
ORDER BY TotalSales DESC;

-- Best Practices
-- Use parameterized queries in SSRS to improve security and flexibility.
-- Optimize T-SQL queries for reports to reduce execution time.
-- Store reports in the SSRS Report Server for centralized access.
-- Use shared data sources for reusability across reports.
-- Test report rendering with large datasets for performance.

-- Clean Up
DROP TABLE Sales;