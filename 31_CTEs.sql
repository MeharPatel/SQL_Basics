-- Common Table Expressions (CTEs)

-- What is a CTE?
-- A Common Table Expression (CTE) is a temporary result set defined within a query.
-- Improves readability and allows recursive queries.

-- Key Features
-- Defined using WITH clause, followed by a query.
-- Can be referenced multiple times in the main query.
-- Supports recursive CTEs for hierarchical or iterative data.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    ManagerID INT
);
INSERT INTO Employees (EmployeeID, FirstName, ManagerID)
VALUES (1, 'John', NULL),
       (2, 'Jane', 1),
       (3, 'Alice', 1),
       (4, 'Bob', 2);

-- Basic CTE
-- Defines a CTE for high-level employees.
WITH HighLevelEmployees AS (
    SELECT EmployeeID, FirstName
    FROM Employees
    WHERE ManagerID IS NULL
)
SELECT * FROM HighLevelEmployees;

-- CTE with Joins
-- Joins a CTE with another table.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'IT'),
       (2, 'HR');

WITH EmployeeCTE AS (
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, d.DepartmentName
    FROM Employees e
    JOIN Departments d ON e.EmployeeID = d.DepartmentID
)
SELECT FirstName, DepartmentName
FROM EmployeeCTE
WHERE ManagerID IS NOT NULL;

-- Recursive CTE
-- Retrieves employee hierarchy.
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, FirstName, ManagerID, 0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT FirstName, Level
FROM EmployeeHierarchy
ORDER BY Level;

-- Best Practices
-- Use CTEs for better query readability over subqueries.
-- Limit recursive CTE depth to avoid performance issues.
-- Use meaningful CTE names to reflect their purpose.
-- Combine with other clauses (e.g., GROUP BY, ORDER BY) for complex logic.
-- Test recursive CTEs with small datasets to verify correctness.

-- Clean Up
DROP TABLE Employees;
DROP TABLE Departments;