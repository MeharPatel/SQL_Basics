-- User-Defined Functions (Scalar and Table-Valued)

-- What are User-Defined Functions (UDFs)?
-- UDFs are custom T-SQL functions created to encapsulate reusable logic.
-- Two main types: Scalar (returns a single value) and Table-Valued (returns a table).

-- Key Features
-- Scalar UDFs: Return one value, used in SELECT or WHERE clauses.
-- Table-Valued UDFs: Return a table, used in FROM or JOIN clauses.
-- Can accept parameters and be deterministic or non-deterministic.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, Salary, HireDate)
VALUES (1, 'John', 60000.00, '2023-01-15'),
       (2, 'Jane', 75000.00, '2022-06-20'),
       (3, 'Alice', 50000.00, '2023-03-10');

-- Scalar UDF
-- Calculates annual salary from monthly salary.
CREATE FUNCTION dbo.CalculateAnnualSalary
(
    @MonthlySalary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END;

-- Using Scalar UDF
SELECT FirstName, Salary, dbo.CalculateAnnualSalary(Salary) AS AnnualSalary
FROM Employees;

-- Inline Table-Valued UDF
-- Returns employees with salaries above a threshold.
CREATE FUNCTION dbo.GetHighEarners
(
    @MinSalary DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT EmployeeID, FirstName, Salary
    FROM Employees
    WHERE Salary >= @MinSalary
);

-- Using Inline Table-Valued UDF
SELECT * FROM dbo.GetHighEarners(60000.00);

-- Multi-Statement Table-Valued UDF
-- Returns employees with calculated years of service.
CREATE FUNCTION dbo.GetEmployeeTenure
(
    @MinYears INT
)
RETURNS @Result TABLE
(
    EmployeeID INT,
    FirstName VARCHAR(50),
    YearsOfService INT
)
AS
BEGIN
    INSERT INTO @Result
    SELECT EmployeeID, FirstName, DATEDIFF(year, HireDate, GETDATE()) AS YearsOfService
    FROM Employees
    WHERE DATEDIFF(year, HireDate, GETDATE()) >= @MinYears;
    RETURN;
END;

-- Using Multi-Statement Table-Valued UDF
SELECT * FROM dbo.GetEmployeeTenure(1);

-- Dropping a UDF
DROP FUNCTION dbo.CalculateAnnualSalary;

-- Best Practices
-- Use scalar UDFs for simple calculations, but avoid in WHERE clauses for performance.
-- Prefer inline table-valued UDFs over multi-statement for better performance.
-- Ensure UDFs are deterministic when used in computed columns or indexes.
-- Use meaningful names and document function purpose.
-- Test UDFs with edge cases (e.g., NULL inputs).

-- Clean Up
DROP FUNCTION IF EXISTS dbo.GetHighEarners;
DROP FUNCTION IF EXISTS dbo.GetEmployeeTenure;
DROP TABLE Employees;