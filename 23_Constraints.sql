-- Constraints

-- What are Constraints?
-- Constraints are rules enforced on table columns to ensure data integrity and consistency.
-- Defined during table creation or altered later using ALTER TABLE.

-- Types of Constraints
-- PRIMARY KEY: Uniquely identifies each row; cannot be NULL.
-- FOREIGN KEY: Ensures referential integrity by linking to a PRIMARY KEY or UNIQUE key in another table.
-- UNIQUE: Ensures all values in a column or set of columns are unique.
-- CHECK: Enforces a condition on column values.
-- DEFAULT: Specifies a default value for a column if no value is provided.

-- Creating a Sample Table for Examples
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) DEFAULT 50000.00,
    DepartmentID INT,
    Email VARCHAR(100),
    Age INT
);

-- PRIMARY KEY Constraint
-- Ensures EmployeeID is unique and not NULL (already defined in CREATE TABLE).
-- Example: EmployeeID in Employees table.

-- FOREIGN KEY Constraint
-- Links DepartmentID in Employees to DepartmentID in Departments.
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- UNIQUE Constraint
-- Ensures Email values are unique.
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Email UNIQUE (Email);

-- CHECK Constraint
-- Ensures Age is between 18 and 65.
ALTER TABLE Employees
ADD CONSTRAINT CHK_Employees_Age CHECK (Age >= 18 AND Age <= 65);

-- DEFAULT Constraint
-- Sets default Salary to 50000.00 (already defined in CREATE TABLE).
-- Can also be added later:
ALTER TABLE Employees
ADD CONSTRAINT DF_Employees_Salary DEFAULT 50000.00 FOR Salary;

-- Inserting Sample Data
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'IT'), (2, 'HR');

INSERT INTO Employees (EmployeeID, FirstName, DepartmentID, Email, Age)
VALUES (1, 'John', 1, 'john@company.com', 30),
       (2, 'Jane', 2, 'jane@company.com', 25);

-- Testing Constraints
-- This will fail due to FOREIGN KEY violation:
-- INSERT INTO Employees (EmployeeID, FirstName, DepartmentID, Email, Age)
-- VALUES (3, 'Alice', 3, 'alice@company.com', 28);

-- This will fail due to CHECK violation:
-- INSERT INTO Employees (EmployeeID, FirstName, DepartmentID, Email, Age)
-- VALUES (3, 'Alice', 1, 'alice@company.com', 17);

-- This will fail due to UNIQUE violation:
-- INSERT INTO Employees (EmployeeID, FirstName, DepartmentID, Email, Age)
-- VALUES (3, 'Alice', 1, 'john@company.com', 28);

-- Dropping a Constraint
ALTER TABLE Employees
DROP CONSTRAINT UQ_Employees_Email;

-- Best Practices
-- Use PRIMARY KEY for unique row identification.
-- Use FOREIGN KEY to maintain referential integrity.
-- Apply CHECK constraints for business rules (e.g., valid ranges).
-- Use DEFAULT to reduce data entry errors.
-- Name constraints explicitly for easier management (e.g., FK_Employees_Departments).

-- Clean Up
DROP TABLE Employees;
DROP TABLE Departments;