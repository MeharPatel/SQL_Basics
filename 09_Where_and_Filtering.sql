-- WHERE Clause and Filtering

-- What is the WHERE Clause?
-- The WHERE clause is used in T-SQL SELECT, UPDATE, and DELETE statements to filter rows based on specific conditions.
-- Reduces the result set to only those rows that meet the specified criteria.

-- Key Components
-- Used with comparison operators: =, <>, >, <, >=, <=
-- Logical operators: AND, OR, NOT
-- Special operators: LIKE, IN, BETWEEN, IS NULL, IS NOT NULL
-- Can be combined with other clauses like ORDER BY or GROUP BY.

-- Creating a Sample Table for Examples
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Grade INT,
    Department VARCHAR(50),
    EnrollmentDate DATE
);

-- Inserting Sample Data
INSERT INTO Students (StudentID, FirstName, LastName, Grade, Department, EnrollmentDate)
VALUES (1, 'John', 'Doe', 85, 'Computer Science', '2023-09-01'),
       (2, 'Jane', 'Smith', 92, 'Mathematics', '2022-09-01'),
       (3, 'Alice', 'Johnson', 78, 'Computer Science', '2023-09-01'),
       (4, 'Bob', 'Brown', 95, 'Mathematics', NULL);

-- Basic WHERE Clause
-- Filters rows based on a single condition.
SELECT FirstName, LastName, Grade
FROM Students
WHERE Department = 'Computer Science';

-- WHERE with Comparison Operators
-- Filters using >, <, etc.
SELECT FirstName, Grade
FROM Students
WHERE Grade >= 90;

-- WHERE with Logical Operators
-- Combines multiple conditions using AND, OR, NOT.
SELECT FirstName, LastName, Department
FROM Students
WHERE Grade > 80 AND Department = 'Mathematics';

-- WHERE with IN Operator
-- Filters rows where a column value matches any value in a list.
SELECT FirstName, Department
FROM Students
WHERE Department IN ('Computer Science', 'Mathematics');

-- WHERE with BETWEEN Operator
-- Filters rows within a range (inclusive).
SELECT FirstName, Grade
FROM Students
WHERE Grade BETWEEN 80 AND 90;

-- WHERE with LIKE Operator
-- Filters rows based on pattern matching (% for any characters, _ for single character).
SELECT FirstName, LastName
FROM Students
WHERE LastName LIKE 'S%';

-- WHERE with IS NULL
-- Filters rows where a column value is NULL.
SELECT FirstName, LastName
FROM Students
WHERE EnrollmentDate IS NULL;

-- WHERE with IS NOT NULL
-- Filters rows where a column value is not NULL.
SELECT FirstName, EnrollmentDate
FROM Students
WHERE EnrollmentDate IS NOT NULL;

-- Complex WHERE Clause
-- Combines multiple operators and conditions.
SELECT FirstName, LastName, Grade, Department
FROM Students
WHERE (Grade > 85 OR Department = 'Computer Science')
AND EnrollmentDate IS NOT NULL;

-- WHERE in UPDATE Statement
-- Updates rows that meet the condition.
UPDATE Students
SET Grade = Grade + 5
WHERE Department = 'Mathematics';

-- WHERE in DELETE Statement
-- Deletes rows that meet the condition.
DELETE FROM Students
WHERE Grade < 80;

-- Best Practices
-- Use precise conditions to minimize data retrieval and improve performance.
-- Index columns frequently used in WHERE clauses for faster filtering.
-- Avoid using functions on columns in WHERE (e.g., WHERE UPPER(FirstName) = 'JOHN') to leverage indexes.
-- Test complex WHERE clauses on small datasets to ensure correct results.
-- Use parentheses to clarify the order of operations in complex conditions.

-- Example with Combined Filtering
SELECT FirstName, LastName, Grade, Department
FROM Students
WHERE Grade BETWEEN 85 AND 95
AND Department LIKE '%Science'
AND EnrollmentDate IS NOT NULL
ORDER BY Grade DESC;

-- Clean Up
DROP TABLE Students;