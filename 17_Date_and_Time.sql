-- Date and Time Functions

-- What are Date and Time Functions?
-- Date and time functions in T-SQL manipulate and process date and time data stored in DATE, DATETIME, DATETIME2, or TIME columns.
-- Used for calculations, formatting, and extracting parts of date/time values.

-- Common Date and Time Functions
-- GETDATE: Returns the current date and time (DATETIME).
-- SYSDATETIME: Returns the current date and time with higher precision (DATETIME2).
-- DATEADD: Adds a specified interval to a date/time.
-- DATEDIFF: Calculates the difference between two dates/times.
-- DATEPART: Extracts a specific part (e.g., year, month, day) from a date/time.
-- DAY, MONTH, YEAR: Extracts day, month, or year from a date.
-- FORMAT: Formats a date/time into a specified string format.
-- ISDATE: Checks if a value is a valid date/time.

-- Creating a Sample Table for Examples
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME,
    DeliveryDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- Inserting Sample Data
INSERT INTO Orders (OrderID, CustomerID, OrderDate, DeliveryDate, TotalAmount)
VALUES (1, 101, '2023-01-15 14:30:00', '2023-01-20', 500.00),
       (2, 102, '2023-02-10 09:15:00', '2023-02-12', 300.00),
       (3, 101, '2023-03-05 16:45:00', NULL, 700.00),
       (4, 103, '2023-04-20 11:00:00', '2023-04-25', 200.00);

-- GETDATE: Current Date and Time
-- Returns the current system date and time.
SELECT OrderID, OrderDate, GETDATE() AS CurrentDateTime
FROM Orders;

-- SYSDATETIME: High-Precision Current Date and Time
SELECT OrderID, OrderDate, SYSDATETIME() AS HighPrecisionDateTime
FROM Orders;

-- DATEADD: Add Interval to Date
-- Adds a specified number of units (e.g., day, month, year) to a date.
SELECT OrderID, OrderDate, DATEADD(day, 7, OrderDate) AS OneWeekLater
FROM Orders;

-- DATEDIFF: Difference Between Dates
-- Calculates the difference in specified units (e.g., day, hour) between two dates.
SELECT OrderID, OrderDate, DeliveryDate,
       DATEDIFF(day, OrderDate, DeliveryDate) AS DaysToDeliver
FROM Orders;

-- DATEPART: Extract Date Part
-- Returns a specific part of a date (e.g., year, month, day).
SELECT OrderID, OrderDate, DATEPART(month, OrderDate) AS OrderMonth
FROM Orders;

-- DAY, MONTH, YEAR: Extract Specific Components
SELECT OrderID, OrderDate, 
       DAY(OrderDate) AS OrderDay,
       MONTH(OrderDate) AS OrderMonth,
       YEAR(OrderDate) AS OrderYear
FROM Orders;

-- FORMAT: Format Date as String
-- Formats a date into a specified string format.
SELECT OrderID, OrderDate, 
       FORMAT(OrderDate, 'yyyy-MM-dd') AS FormattedDate,
       FORMAT(OrderDate, 'MMMM dd, yyyy') AS LongDate
FROM Orders;

-- ISDATE: Validate Date
-- Returns 1 if the value is a valid date, 0 otherwise.
SELECT OrderID, DeliveryDate, ISDATE(DeliveryDate) AS IsValidDate
FROM Orders;

-- Combining Date Functions
-- Calculates delivery time and formats the result.
SELECT OrderID, 
       OrderDate, 
       DeliveryDate,
       DATEDIFF(day, OrderDate, DeliveryDate) AS DeliveryDays,
       FORMAT(DATEADD(day, 10, OrderDate), 'dd-MMM-yyyy') AS FollowUpDate
FROM Orders
WHERE ISDATE(DeliveryDate) = 1;

-- Best Practices
-- Use DATETIME2 for higher precision over DATETIME when needed.
-- Store dates in appropriate data types (DATE, DATETIME, etc.) to avoid conversion issues.
-- Be cautious with regional date formats; use FORMAT for consistent output.
-- Index date columns used in WHERE or JOIN clauses for better performance.
-- Test date functions with NULL values and edge cases (e.g., leap years).

-- Complex Example
SELECT OrderID,
       CustomerID,
       OrderDate,
       FORMAT(OrderDate, 'MMM yyyy') AS OrderMonthYear,
       DATEDIFF(hour, OrderDate, GETDATE()) AS HoursSinceOrder
FROM Orders
WHERE DATEPART(year, OrderDate) = 2023
AND DATEDIFF(day, OrderDate, DeliveryDate) <= 5;

-- Clean Up
DROP TABLE Orders;