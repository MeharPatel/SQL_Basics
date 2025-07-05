-- SQL Server Analysis Services (SSAS)

-- What is SSAS?
-- SQL Server Analysis Services (SSAS) is a platform for building analytical and business intelligence solutions.
-- Supports multidimensional (OLAP) and tabular models for data analysis.

-- Key Features
-- Cubes: Multidimensional data structures for fast querying.
-- Tabular Models: In-memory models for simpler analytics.
-- MDX/DAX Queries: Query languages for OLAP and tabular models.
-- Data Mining: Supports predictive analytics and clustering.
-- Integration with SSRS and Power BI for reporting.

-- Example: Creating a Table for SSAS Data Source
CREATE TABLE SalesFact (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    RegionID INT,
    SaleAmount DECIMAL(10,2),
    SaleDate DATE
);
GO

-- Inserting Sample Data
INSERT INTO SalesFact (SaleID, ProductID, RegionID, SaleAmount, SaleDate)
VALUES (1, 101, 1, 500.00, '2023-01-15'),
       (2, 102, 2, 300.00, '2023-02-10');

-- T-SQL Query for SSAS Data Source
-- Aggregates data for cube or tabular model.
SELECT RegionID, YEAR(SaleDate) AS SaleYear, SUM(SaleAmount) AS TotalSales
FROM SalesFact
GROUP BY RegionID, YEAR(SaleDate);

-- Best Practices
-- Use SSAS for complex analytical queries and aggregations.
-- Design dimensions and measures carefully for cube/tabular models.
-- Optimize data sources with indexes for faster processing.
-- Secure SSAS models with role-based permissions.
-- Monitor SSAS performance using SQL Server Profiler or DMVs.

-- Clean Up
DROP TABLE SalesFact;