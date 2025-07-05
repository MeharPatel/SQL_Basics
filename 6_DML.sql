-- Data Manipulation Language (DML)

-- What is DML?
-- DML (Data Manipulation Language) is a subset of T-SQL used to manipulate data within database tables.
-- Includes commands to insert, update, delete, and retrieve data.

-- Common DML Commands
-- SELECT: Retrieves data from one or more tables.
-- INSERT: Adds new rows to a table.
-- UPDATE: Modifies existing rows in a table.
-- DELETE: Removes rows from a table.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

-- INSERT: Adding Data
-- Inserts one or more rows into a table.
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Department)
VALUES (1, 'John', 'Doe', 60000.00, 'IT'),
       (2, 'Jane', 'Smith', 75000.00, 'HR');

-- INSERT with Specific Columns
INSERT INTO Employees (EmployeeID, FirstName, Salary)
VALUES (3, 'Alice', 50000.00);

-- SELECT: Retrieving Data
-- Retrieves specific columns or all columns (*) from a table.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Department = 'IT';

-- SELECT with All Columns
SELECT * FROM Employees;

-- UPDATE: Modifying Data
-- Updates existing rows based on a condition.
UPDATE Employees
SET Salary = Salary + 5000
WHERE Department = 'HR';

-- UPDATE Multiple Columns
UPDATE Employees
SET LastName = 'Johnson', Department = 'Finance'
WHERE EmployeeID = 1;

-- DELETE: Removing Data
-- Deletes rows based on a condition.
DELETE FROM Employees
WHERE Salary < 55000;

-- DELETE All Rows (without dropping table)
DELETE FROM Employees;

-- Combining DML with Conditions
-- Using WHERE for precise data manipulation.
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Department)
VALUES (4, 'Bob', 'Brown', 65000.00, 'IT');

SELECT FirstName, Salary
FROM Employees
WHERE Salary > 60000
ORDER BY Salary DESC;

-- Bulk Insert Example
-- Insert multiple rows from another table or query.
CREATE TABLE TempEmployees (
    EmployeeID INT,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO TempEmployees (EmployeeID, FirstName, Salary)
SELECT EmployeeID, FirstName, Salary
FROM Employees
WHERE Department = 'IT';

-- Best Practices
-- Always use WHERE clauses with UPDATE and DELETE to avoid unintended changes.
-- Validate data before INSERT to ensure it matches column data types and constraints.
-- Use transactions for critical DML operations to ensure data integrity.
-- Test DML statements on a backup or test database first.

-- Example with Transaction
BEGIN TRANSACTION;
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Department)
VALUES (5, 'Mary', 'Davis', 70000.00, 'Sales');
UPDATE Employees
SET Salary = 72000.00
WHERE EmployeeID = 5;
IF @@ERROR = 0
    COMMIT TRANSACTION;
ELSE
    ROLLBACK TRANSACTION;

-- Clean Up
DROP TABLE Employees;
DROP TABLE TempEmployees;