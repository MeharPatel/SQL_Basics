-- Pivot and Unpivot

-- What are PIVOT and UNPIVOT?
-- PIVOT: Transforms rows into columns (e.g., for cross-tab reports).
-- UNPIVOT: Converts columns into rows (reverse of PIVOT).
-- Used to reshape data for analysis or reporting.

-- Creating a Sample Table for Examples
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleYear INT,
    Amount DECIMAL(10,2)
);
INSERT INTO Sales (SaleID, ProductID, SaleYear, Amount)
VALUES (1, 101, 2022, 500.00),
       (2, 101, 2023, 600.00),
       (3, 102, 2022, 300.00),
       (4, 102, 2023, 400.00);

-- PIVOT
-- Converts SaleYear rows into columns.
SELECT * 
FROM Sales
PIVOT (
    SUM(Amount)
    FOR SaleYear IN ([2022], [2023])
) AS PivotTable;

-- UNPIVOT
-- Converts columns back into rows.
CREATE TABLE PivotedSales (
    ProductID INT,
    [2022] DECIMAL(10,2),
    [2023] DECIMAL(10,2)
);
INSERT INTO PivotedSales (ProductID, [2022], [2023])
VALUES (101, 500.00, 600.00),
       (102, 300.00, 400.00);

SELECT ProductID, SaleYear, Amount
FROM PivotedSales
UNPIVOT (
    Amount FOR SaleYear IN ([2022], [2023])
) AS UnpivotTable;

-- Best Practices
-- Ensure clean data to avoid unexpected results in PIVOT/UNPIVOT.
-- Use meaningful column names in PIVOT’s FOR clause.
-- Combine PIVOT with dynamic SQL for dynamic column lists.
-- Test PIVOT/UNPIVOT with small datasets for accuracy.
-- Use indexes on pivoted columns for performance.

-- Clean Up
DROP TABLE Sales;
DROP TABLE PivotedSales;