-- Subqueries (Nested and Correlated)

-- What are Subqueries?
-- A subquery is a query nested inside another query, used to return data that the outer query processes.
-- Enclosed in parentheses and typically used in SELECT, WHERE, or FROM clauses.
-- Two types: Nested (independent) and Correlated (depends on the outer query).

-- Nested Subquery
-- Runs independently of the outer query and returns a result used by the outer query.
-- Can return a single value, a single row, or multiple rows.

-- Correlated Subquery
-- Depends on the outer query for its values, executed for each row of the outer query.
-- Often used for row-by-row comparisons.

-- Creating Sample Tables for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, Salary, DepartmentID)
VALUES (1, 'John', 60000.00, 1),
       (2, 'Jane', 75000.00, 2),
       (3, 'Alice', 50000.00, 1),
       (4, 'Bob', 80000.00, 3);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'IT'),
       (2, 'HR'),
       (3, 'Finance');

-- Nested Subquery (Single Value)
-- Returns a single value to filter the outer query.
SELECT FirstName, Salary
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'IT');

-- Nested Subquery (Multiple Values with IN)
-- Returns multiple values to filter using IN.
SELECT FirstName, Salary
FROM Employees
WHERE DepartmentID IN (SELECT DepartmentID FROM Departments WHERE DepartmentName IN ('IT', 'HR'));

-- Nested Subquery in SELECT
-- Returns a single value for each row in the outer query.
SELECT FirstName, Salary,
       (SELECT DepartmentName FROM Departments d WHERE d.DepartmentID = e.DepartmentID) AS DeptName
FROM Employees e;

-- Correlated Subquery
-- Uses values from the outer query, executed for each row.
SELECT FirstName, Salary
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Departments d
    WHERE d.DepartmentID = e.DepartmentID AND d.DepartmentName = 'Finance'
);

-- Correlated Subquery with Comparison
-- Compares each employee’s salary to the average salary in their department.
SELECT FirstName, Salary, DepartmentID
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);

-- Nested Subquery in FROM
-- Treats the subquery as a derived table.
SELECT FirstName, Salary
FROM (
    SELECT FirstName, Salary, DepartmentID
    FROM Employees
    WHERE Salary > 55000
) AS HighEarners
WHERE DepartmentID = 1;

-- Best Practices
-- Use subqueries when joins are less readable or not feasible.
-- Prefer correlated subqueries for row-by-row logic, but avoid overuse due to performance impact.
-- Index columns used in subquery conditions to improve performance.
-- Test subqueries on small datasets to ensure correctness.
-- Consider Common Table Expressions (CTEs) or joins for complex subqueries to improve readability.

-- Complex Example with Nested and Correlated Subqueries
SELECT FirstName, Salary, DepartmentID
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
)
AND DepartmentID IN (
    SELECT DepartmentID
    FROM Departments
    WHERE DepartmentName LIKE '%I%'
)
ORDER BY Salary DESC;

-- Clean Up
DROP TABLE Employees;
DROP TABLE Departments;