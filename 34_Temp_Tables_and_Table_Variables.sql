-- Temporary Tables and Table Variables

-- What are Temporary Tables and Table Variables?
-- Temporary Tables: Physical tables stored in tempdb, exist for the session or until dropped.
-- Table Variables: In-memory variables, scoped to the batch or procedure.

-- Key Differences
-- Temporary Tables: Support indexes, statistics, and transactions; larger overhead.
-- Table Variables: Limited indexing, no statistics, lighter overhead.

-- Creating a Temporary Table
CREATE TABLE #TempOrders (
    OrderID INT,
    Amount DECIMAL(10,2)
);
INSERT INTO #TempOrders (OrderID, Amount)
VALUES (1, 500.00),
       (2, 300.00);

-- Querying Temporary Table
SELECT * FROM #TempOrders;

-- Creating a Table Variable
DECLARE @OrderTable TABLE (
    OrderID INT,
    Amount DECIMAL(10,2)
);
INSERT INTO @OrderTable (OrderID, Amount)
VALUES (1, 600.00),
       (2, 400.00);

-- Querying Table Variable
SELECT * FROM @OrderTable;

-- Indexing Temporary Table
CREATE NONCLUSTERED INDEX IX_TempOrders_Amount
ON #TempOrders (Amount);

-- Best Practices
-- Use temporary tables for large datasets or complex indexing needs.
-- Use table variables for small, simple datasets.
-- Explicitly drop temporary tables to free resources.
-- Avoid excessive use of tempdb to prevent contention.
-- Test performance with both to choose the best option.

-- Clean Up
DROP TABLE #TempOrders;