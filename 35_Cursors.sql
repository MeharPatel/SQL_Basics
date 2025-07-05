-- Cursors

-- What are Cursors?
-- Cursors allow row-by-row processing of query results in T-SQL.
-- Used for iterative tasks not easily handled by set-based operations.

-- Key Components
-- DECLARE: Defines the cursor and its query.
-- OPEN: Executes the cursor’s query.
-- FETCH: Retrieves the next row.
-- CLOSE and DEALLOCATE: Release cursor resources.

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, Salary)
VALUES (1, 'John', 50000.00),
       (2, 'Jane', 60000.00),
       (3, 'Alice', 55000.00);

-- Basic Cursor
-- Updates salaries row by row.
DECLARE @EmployeeID INT, @Salary DECIMAL(10,2);
DECLARE employee_cursor CURSOR FOR
SELECT EmployeeID, Salary
FROM Employees;
OPEN employee_cursor;
FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Salary;
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Employees
    SET Salary = @Salary * 1.1
    WHERE EmployeeID = @EmployeeID;
    FETCH NEXT FROM employee_cursor INTO @EmployeeID, @Salary;
END;
CLOSE employee_cursor;
DEALLOCATE employee_cursor;

-- Querying Updated Data
SELECT * FROM Employees;

-- Best Practices
-- Avoid cursors for set-based operations; use joins or aggregates instead.
-- Use FAST_FORWARD cursors for read-only, forward-only operations to improve performance.
-- Explicitly close and deallocate cursors to free resources.
-- Test cursors with small datasets to verify logic.
-- Consider WHILE loops or CTEs as alternatives for simple iterations.

-- Clean Up
DROP TABLE Employees;