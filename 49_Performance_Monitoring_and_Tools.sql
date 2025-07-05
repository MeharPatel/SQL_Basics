-- Performance Monitoring and Tools

-- What is Performance Monitoring?
-- Performance monitoring tracks SQL Server performance to identify and resolve bottlenecks.
-- Uses built-in tools and Dynamic Management Views (DMVs) for analysis.

-- Key Tools
-- Query Store: Tracks query performance and execution plans.
-- SQL Server Profiler: Monitors server events.
-- DMVs/DMFs: Provide runtime statistics (e.g., sys.dm_exec_query_stats).
-- Extended Events: Lightweight event tracking.
-- Performance Monitor: Tracks server and OS metrics.

-- Creating a Sample Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    Amount DECIMAL(10,2)
);
GO
INSERT INTO Orders (OrderID, Amount)
VALUES (1, 500.00), (2, 300.00);

-- Querying DMV for Top Queries
SELECT TOP 5 
    t.text AS QueryText,
    s.execution_count,
    s.total_elapsed_time
FROM sys.dm_exec_query_stats s
CROSS APPLY sys.dm_exec_sql_text(s.sql_handle) t
ORDER BY s.total_elapsed_time DESC;

-- Enabling Query Store
ALTER DATABASE YourDB
SET QUERY_STORE = ON;

-- Best Practices
-- Use Query Store to identify regressed queries after upgrades.
-- Monitor DMVs like sys.dm_os_wait_stats for wait types.
-- Use Extended Events for lightweight performance tracking.
-- Set up Performance Monitor counters for CPU, memory, and disk I/O.
-- Regularly analyze execution plans for optimization opportunities.

-- Clean Up
DROP TABLE Orders;