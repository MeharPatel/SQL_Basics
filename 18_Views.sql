-- Views

-- What is a View?
-- A view is a virtual table based on the result of a SELECT query.
-- Stores the query definition, not the data, and retrieves fresh data when queried.
-- Used to simplify complex queries, enhance security, or provide a customized view of data.

-- Key Features
-- Can be queried like a table.
-- Supports SELECT, but limited support for INSERT, UPDATE, DELETE (with restrictions).
-- Can include joins, aggregates, or computed columns.
-- Can be indexed (Indexed Views) for performance in Enterprise edition.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES (1, 'John', 'Doe', 60000.00, 1),
       (2, 'Jane', 'Smith', 75000.00, 2),
       (3, 'Alice', 'Johnson', 50000.00, 1);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'IT'),
       (2, 'HR');

-- Creating a View
-- Creates a virtual table combining employee and department data.
CREATE VIEW EmployeeDetails AS
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Querying a View
-- Treats the view like a table.
SELECT FirstName, LastName, DepartmentName
FROM EmployeeDetails
WHERE Salary > 55000;

-- Altering a View
-- Modifies the view definition.
ALTER VIEW EmployeeDetails AS
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName, 
       e.Salary * 12 AS AnnualSalary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Dropping a View
-- Deletes the view definition.
DROP VIEW EmployeeDetails;

-- Creating a View with Aggregation
-- Summarizes data by department.
CREATE VIEW DepartmentSummary AS
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount, AVG(e.Salary) AS AvgSalary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- Querying the Aggregated View
SELECT DepartmentName, EmployeeCount, AvgSalary
FROM DepartmentSummary
WHERE EmployeeCount > 1;

-- Best Practices
-- Use views to simplify complex queries or restrict access to specific columns.
-- Avoid excessive nesting of views to prevent performance issues.
-- Use meaningful names for views to reflect their purpose.
-- Consider indexed views for frequently queried data (Enterprise edition only).
-- Document view purposes and dependencies for maintenance.

-- Clean Up
DROP VIEW IF EXISTS DepartmentSummary;
DROP TABLE Employees;
DROP TABLE Departments;