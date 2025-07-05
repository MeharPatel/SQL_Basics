-- SELECT Queries

-- What is a SELECT Query?
-- SELECT is a T-SQL Data Manipulation Language (DML) command used to retrieve data from one or more tables.
-- Allows filtering, sorting, and combining data with various clauses and functions.

-- Key Components
-- SELECT: Specifies columns to retrieve.
-- FROM: Defines the table(s) to query.
-- Optional Clauses:
--   WHERE: Filters rows based on conditions.
--   ORDER BY: Sorts results.
--   TOP: Limits the number of rows returned.
--   DISTINCT: Removes duplicate rows.
--   GROUP BY: Groups rows for aggregate calculations.
--   JOIN: Combines data from multiple tables.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    HireDate DATE
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Department, HireDate)
VALUES (1, 'John', 'Doe', 60000.00, 'IT', '2023-01-15'),
       (2, 'Jane', 'Smith', 75000.00, 'HR', '2022-06-20'),
       (3, 'Alice', 'Johnson', 50000.00, 'IT', '2024-03-10'),
       (4, 'Bob', 'Brown', 80000.00, 'HR', '2021-11-05');

-- Basic SELECT Query
-- Retrieves specific columns from a table.
SELECT FirstName, LastName, Salary
FROM Employees;

-- SELECT All Columns
-- Uses * to retrieve all columns.
SELECT * FROM Employees;

-- SELECT with WHERE Clause
-- Filters rows based on a condition.
SELECT FirstName, Department
FROM Employees
WHERE Salary > 60000;

-- SELECT with ORDER BY
-- Sorts results (ASC for ascending, DESC for descending).
SELECT LastName, Salary
FROM Employees
ORDER BY Salary DESC;

-- SELECT with TOP
-- Limits the number of rows returned.
SELECT TOP 2 FirstName, Salary
FROM Employees
ORDER BY Salary DESC;

-- SELECT with DISTINCT
-- Removes duplicate rows.
SELECT DISTINCT Department
FROM Employees;

-- SELECT with Aggregate Functions
-- Uses functions like COUNT, SUM, AVG, MIN, MAX.
SELECT Department, COUNT(*) AS EmployeeCount, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- SELECT with Aliases
-- Assigns temporary names to columns or tables.
SELECT FirstName AS Name, Salary AS AnnualSalary
FROM Employees AS E
WHERE E.Department = 'IT';

-- SELECT with Calculated Columns
-- Performs calculations in the query.
SELECT FirstName, Salary, Salary * 12 AS YearlySalary
FROM Employees;

-- SELECT with Multiple Conditions
-- Uses AND, OR, NOT for complex filtering.
SELECT FirstName, LastName, HireDate
FROM Employees
WHERE Department = 'HR' AND Salary >= 70000;

-- Best Practices
-- Specify only needed columns instead of using * for better performance.
-- Use meaningful aliases for clarity.
-- Ensure WHERE conditions are precise to avoid unnecessary data retrieval.
-- Index frequently filtered columns to improve query performance.
-- Test queries on large datasets to ensure efficiency.

-- Example with Combined Features
SELECT TOP 3 FirstName, LastName, Salary, Department
FROM Employees
WHERE Salary > 55000 AND Department IN ('IT', 'HR')
ORDER BY HireDate ASC;

-- Clean Up
DROP TABLE Employees;