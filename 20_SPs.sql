-- Stored Procedures

-- What is a Stored Procedure?
-- A stored procedure is a precompiled set of T-SQL statements stored in the database.
-- Used to encapsulate logic, improve performance, and enhance security.

-- Key Features
-- Can accept parameters (input/output).
-- Can return results or status codes.
-- Reduces network traffic by executing logic on the server.
-- Can be called from applications or other T-SQL scripts.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, Salary, DepartmentID)
VALUES (1, 'John', 60000.00, 1),
       (2, 'Jane', 75000.00, 2),
       (3, 'Alice', 50000.00, 1);

-- Creating a Stored Procedure
-- Retrieves employees by department.
CREATE PROCEDURE GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT EmployeeID, FirstName, Salary
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

-- Executing a Stored Procedure
EXEC GetEmployeesByDepartment @DeptID = 1;

-- Creating a Stored Procedure with Output Parameter
-- Returns the count of employees in a department.
CREATE PROCEDURE GetEmployeeCount
    @DeptID INT,
    @EmpCount INT OUTPUT
AS
BEGIN
    SELECT @EmpCount = COUNT(*)
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

-- Executing with Output Parameter
DECLARE @Count INT;
EXEC GetEmployeeCount @DeptID = 1, @EmpCount = @Count OUTPUT;
SELECT @Count AS EmployeeCount;

-- Altering a Stored Procedure
ALTER PROCEDURE GetEmployeesByDepartment
    @DeptID INT,
    @MinSalary DECIMAL(10,2) = 0
AS
BEGIN
    SELECT EmployeeID, FirstName, Salary
    FROM Employees
    WHERE DepartmentID = @DeptID AND Salary >= @MinSalary;
END;

-- Dropping a Stored Procedure
DROP PROCEDURE GetEmployeesByDepartment;

-- Best Practices
-- Use meaningful names and include parameter validation.
-- Include error handling with TRY...CATCH for robustness.
-- Avoid excessive logic in stored procedures for maintainability.
-- Use stored procedures to encapsulate repetitive or complex queries.
-- Document parameters and purpose for future reference.

-- Complex Example with Error Handling
CREATE PROCEDURE UpdateEmployeeSalary
    @EmpID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmpID;
        IF @@ROWCOUNT = 0
            THROW 50001, 'Employee not found.', 1;
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;

-- Executing Complex Procedure
EXEC UpdateEmployeeSalary @EmpID = 1, @NewSalary = 65000.00;

-- Clean Up
DROP PROCEDURE IF EXISTS GetEmployeeCount;
DROP PROCEDURE IF EXISTS UpdateEmployeeSalary;
DROP TABLE Employees;