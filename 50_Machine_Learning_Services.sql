-- Machine Learning Services (R, Python, Java)

-- What are Machine Learning Services?
-- SQL Server Machine Learning Services (2017+) integrate R, Python, and Java for in-database analytics.
-- Allows running machine learning scripts within T-SQL.

-- Key Features
-- Execute R/Python scripts using sp_execute_external_script.
-- Supports predictive modeling, clustering, and data visualization.
-- Processes data directly in SQL Server for performance.

-- Creating a Sample Table
CREATE TABLE SalesData (
    SaleID INT PRIMARY KEY,
    Amount DECIMAL(10,2),
    Region VARCHAR(50)
);
GO
INSERT INTO SalesData (SaleID, Amount, Region)
VALUES (1, 500.00, 'North'),
       (2, 300.00, 'South');

-- Python Example: Calculate Average Sales
EXEC sp_execute_external_script
    @language = N'Python',
    @script = N'
import pandas as pd
output_data = InputDataSet.groupby("Region")["Amount"].mean().reset_index()
',
    @input_data_1 = N'SELECT Region, Amount FROM SalesData',
    @output_data_1_name = N'output_data'
WITH RESULT SETS ((Region VARCHAR(50), AvgAmount DECIMAL(10,2)));

-- Best Practices
-- Enable Machine Learning Services during SQL Server setup.
-- Use Python for advanced analytics, R for statistical modeling.
-- Secure external scripts with appropriate permissions.
-- Optimize input queries to reduce data sent to scripts.
-- Test scripts in development before production deployment.

-- Clean Up
DROP TABLE SalesData;