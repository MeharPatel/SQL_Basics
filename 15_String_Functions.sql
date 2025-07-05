-- String Functions

-- What are String Functions?
-- String functions in T-SQL manipulate and process text data stored in VARCHAR, NVARCHAR, CHAR, or NCHAR columns.
-- Used to transform, extract, or analyze string values in queries.

-- Common String Functions
-- LEN: Returns the length of a string (excluding trailing spaces).
-- UPPER: Converts a string to uppercase.
-- LOWER: Converts a string to lowercase.
-- LTRIM: Removes leading spaces.
-- RTRIM: Removes trailing spaces.
-- TRIM: Removes leading and trailing spaces.
-- SUBSTRING: Extracts a portion of a string.
-- LEFT: Returns the leftmost characters of a string.
-- RIGHT: Returns the rightmost characters of a string.
-- REPLACE: Replaces all occurrences of a substring with another.
-- CONCAT: Concatenates two or more strings.
-- CHARINDEX: Finds the starting position of a substring in a string.
-- PATINDEX: Finds the position of a pattern in a string (supports wildcards).

-- Creating a Sample Table for Examples
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email NVARCHAR(100),
    Department VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Department)
VALUES (1, ' John ', 'Doe', 'john.doe@company.com', ' IT '),
       (2, 'Jane', 'Smith ', 'jane.smith@company.com', 'HR'),
       (3, 'Alice', 'Johnson', 'alice.j@company.com', 'Finance');

-- LEN: Get String Length
-- Returns the number of characters in a string (excludes trailing spaces).
SELECT FirstName, LEN(FirstName) AS NameLength
FROM Employees;

-- UPPER and LOWER: Change Case
-- Converts strings to uppercase or lowercase.
SELECT UPPER(FirstName) AS UpperName, LOWER(LastName) AS LowerLastName
FROM Employees;

-- LTRIM, RTRIM, TRIM: Remove Spaces
-- Removes leading, trailing, or both leading and trailing spaces.
SELECT TRIM(FirstName) AS TrimmedName, LTRIM(Department) AS TrimmedDept
FROM Employees;

-- SUBSTRING: Extract Part of a String
-- Extracts characters from a string (start, length).
SELECT FirstName, SUBSTRING(Email, 1, CHARINDEX('@', Email) - 1) AS EmailUser
FROM Employees;

-- LEFT and RIGHT: Extract Characters
-- Returns specified number of characters from the left or right.
SELECT FirstName, LEFT(Email, 5) AS EmailStart, RIGHT(Email, 11) AS EmailEnd
FROM Employees;

-- REPLACE: Replace Substring
-- Replaces all occurrences of a substring with another string.
SELECT Email, REPLACE(Email, 'company', 'org') AS NewEmail
FROM Employees;

-- CONCAT: Concatenate Strings
-- Combines multiple strings into one.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

-- CHARINDEX: Find Substring Position
-- Returns the starting position of a substring (0 if not found).
SELECT Email, CHARINDEX('@', Email) AS AtPosition
FROM Employees;

-- PATINDEX: Find Pattern Position
-- Returns the position of a pattern (supports wildcards).
SELECT Email, PATINDEX('%@%.com', Email) AS PatternPosition
FROM Employees;

-- Combining String Functions
-- Uses multiple functions for complex string manipulation.
SELECT CONCAT(UPPER(LEFT(FirstName, 1)), LOWER(SUBSTRING(FirstName, 2, LEN(FirstName)))) AS FormattedName
FROM Employees;

-- Best Practices
-- Use NVARCHAR for multilingual text to support Unicode characters.
-- Avoid using string functions on indexed columns in WHERE clauses to maintain performance.
-- Combine TRIM with other functions to clean data before processing.
-- Test string functions with edge cases (e.g., NULL, empty strings).
-- Use LEN instead of DATALENGTH for character count (DATALENGTH includes bytes).

-- Complex Example
SELECT EmployeeID,
       CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS FullName,
       SUBSTRING(Email, 1, CHARINDEX('@', Email) - 1) AS Username,
       REPLACE(Department, 'Finance', 'Accounting') AS UpdatedDept
FROM Employees
WHERE PATINDEX('%@company.com', Email) > 0;

-- Clean Up
DROP TABLE Employees;